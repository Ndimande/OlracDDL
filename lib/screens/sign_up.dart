import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/app_data.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/models/profile.dart';
import 'package:olracddl/repos/country.dart';
import 'package:olracddl/screens/home.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  /// First and last name
  String _username = AppConfig.debugMode ? 'debugmode' : '';

  /// Email address
  String _email = AppConfig.debugMode ? 'debugmode' : '';

  Country _country;

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  Future<void> _onPressSaveButton() async {
    final Profile profile = Profile(
      country: _country,
      username: _username,
      email: _email,
      uuid: Uuid().v4(),
    );
    await Profile.set(profile);
    AppData.profile = profile;

    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  bool _allValid() {
    if (_username.isEmpty || _email.isEmpty || _country == null) {
      return false;
    }

    return true;
  }

  Widget _nameTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextFormField(
            style: Theme.of(context).textTheme.headline3,
            initialValue: _username,
            textInputAction: TextInputAction.next,
            focusNode: _nameFocusNode,
            onChanged: (String name) => setState(() => _username = name),
            keyboardType: TextInputType.text,
            autocorrect: false,
            textCapitalization: TextCapitalization.words,
            onFieldSubmitted: (value) {
              _nameFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
          )
        ],
      ),
    );
  }

  Widget _emailTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextFormField(
            style: Theme.of(context).textTheme.headline3,
            initialValue: _email,
            textInputAction: TextInputAction.done,
            focusNode: _emailFocusNode,
            onChanged: (String email) => setState(() => _email = email),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (value) {
              _emailFocusNode.unfocus();
            },
          )
        ],
      ),
    );
  }

  Widget _countryDropdown() {
    Future<List<Country>> getCountries() async => CountryRepo().all();
    return FutureBuilder(
      future: getCountries(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const TextField();
        }
        final List<Country> countries = snapshot.data;

        return DDLModelDropdown<Country>(
          labelTheme: true,
          selected: _country,
          label: 'Country',
          onChanged: (Country country) => setState(() => _country = country),
          items: countries.map<DropdownMenuItem<Country>>((Country country) {
            return DropdownMenuItem<Country>(
              value: country,
              child: Text(country.name,),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _body() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            _nameTextInput(),
            _emailTextInput(),
            _countryDropdown(),
            const SizedBox(height: 70),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_saveButton()],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _saveButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15,),
      child: StripButton(
        color: _allValid() ? Theme.of(context).accentColor : Colors.grey,
        labelText: 'Save',
        onPressed: _allValid() ? _onPressSaveButton : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      title: 'Sign Up',
      body: _body(),
    );
  }
}
