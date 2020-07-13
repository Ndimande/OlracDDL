import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  /// First and last name
  String _name = '';

  /// Role at the factory. e.g manager
  String _positionAtFactory = '';

  /// Email address
  String _email = '';

  /// Phone number
  String _contactNumber = '';

  /// The name of the company
  String _companyName = '';

  /// The name of the factory
  String _factoryName = '';

  /// The street or other address of the factory
  String _factoryAddress = '';

  Future<void> _onPressSaveButton() async {
//    if (!_allValid()) {
//      return;
//    }
//
//    final profile = Profile(
//      name: _name,
//    );
//    await Profile.set(profile);
//
//    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  bool _allValid() {
    if (_factoryName.isEmpty ||
        _name.isEmpty ||
        _positionAtFactory.isEmpty ||
        _email.isEmpty ||
        _contactNumber.isEmpty ||
        _companyName.isEmpty ||
        _factoryName.isEmpty ||
        _factoryAddress.isEmpty) {
      return false;
    }

    return true;
  }

  Widget _nameTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String name) => setState(() => _name = name),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _positionAtFactoryTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Position at Factory', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String positionAtFactory) => setState(() => _positionAtFactory = positionAtFactory),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _emailTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String email) => setState(() => _email = email),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _contactNumberTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Number', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String contactNumber) => setState(() => _contactNumber = contactNumber),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _factoryNameTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Factory Name', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String factoryName) => setState(() => _factoryName = factoryName),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _factoryAddressTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Factory Address', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String factoryAddress) => setState(() => _factoryAddress = factoryAddress),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _companyNameTextInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Company Name', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 5),
          TextField(
            onChanged: (String companyName) => setState(() => _companyName = companyName),
            keyboardType: TextInputType.text,
          )
        ],
      ),
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
            _positionAtFactoryTextInput(),
            _companyNameTextInput(),
            _factoryNameTextInput(),
            _factoryAddressTextInput(),
            _contactNumberTextInput(),
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

  StripButton _saveButton() {
    return StripButton(
      color: _allValid() ? Theme.of(context).accentColor : Colors.grey,
      labelText: 'Save',
      onPressed: _onPressSaveButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      title: 'Profile',
      body: _body(),
    );
  }
}
