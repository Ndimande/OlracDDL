import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/location_editor.dart';

class EndTripInformationDialog extends StatefulWidget {
  @override
  _EndTripInformationDialogState createState() => _EndTripInformationDialogState();
}

class _EndTripInformationDialogState extends State<EndTripInformationDialog> {
  Location _location;

  DateTime _endedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    getLocation().then((Location l) {
      setState(() {
        _location = l;
      });
    });
  }

  Future<Location> getLocation() async {
    final Position p = await Geolocator().getCurrentPosition();
    return Location(latitude: p.latitude, longitude: p.longitude);
  }

  Widget _dateAndTime() {
    return DateTimeEditor(
      title: AppLocalizations.of(context).getTranslatedValue('date_and_time'),
      initialDateTime: _endedAt,
      onChanged: (Picker picker, List<int> selectedIndices) {
        setState(() {
          _endedAt = DateTime.parse(picker.adapter.toString());
        });
      },
      titleStyle: Theme.of(context).textTheme.headline3,
      fieldColor: OlracColoursLight.olspsExtraLightBlue,
    );
  }

  Widget _locationInput() {
    return LocationEditor(
      subTitleStyle: Theme.of(context).textTheme.headline6,
      fieldColor: OlracColoursLight.olspsExtraLightBlue,
      title: AppLocalizations.of(context).getTranslatedValue('location'),
      titleStyle: Theme.of(context).textTheme.headline3,
      location: _location ?? Location(latitude: 0, longitude: 0),
      onChanged: (Location l) {
        setState(() {
          _location = l;
        });
      },
    );
  }

  void _onPressSaveButton() {
    Navigator.pop(context, {
      'endedAt': _endedAt,
      'endLocation': _location,
    });
  }

  Widget _saveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          child: Text(
            AppLocalizations.of(context).getTranslatedValue('save'),
            style: Theme.of(context).textTheme.headline4,
          ),
          onPressed: _onPressSaveButton,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).getTranslatedValue('end_trip_information'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            _dateAndTime(),
            _locationInput(),
            const SizedBox(height: 5),
            _saveButton()
          ],
        ),
      ),
    );
  }
}
