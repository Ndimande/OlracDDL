import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/location_editor.dart';

class EndSetInformationDialog extends StatefulWidget {
  @override
  _EndSetInformationDialogState createState() => _EndSetInformationDialogState();
}

class _EndSetInformationDialogState extends State<EndSetInformationDialog> {
  DateTime _endedAt = DateTime.now();
  Location _endLocation;
  String _hooks, _traps, _linesUsed;

  bool _allValid() {
    if (_endedAt == null) {
      return false;
    }

    if (_endLocation == null) {
      return false;
    }

    if (_hooks == null || int.tryParse(_hooks) == null) {
      return false;
    }

    if (_traps == null || int.tryParse(_traps) == null) {
      return false;
    }

    if (_linesUsed == null || int.tryParse(_linesUsed) == null) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((Location l) {
      setState(() {
        _endLocation = l;
      });
    });
  }

  Future<Location> getLocation() async {
    final Position p = await Geolocator().getCurrentPosition();
    return Location(latitude: p.latitude, longitude: p.longitude);
  }

  void _onPressSave() {
    if (!_allValid()) {
      return;
    }

    final returnValues = <String, dynamic>{
      'endedAt': _endedAt,
      'endLocation': _endLocation,
      'hooks': int.parse(_hooks),
      'traps': int.parse(_traps),
      'linesUsed': int.parse(_linesUsed),
    };

    Navigator.pop(context, returnValues);
  }

  Widget _saveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          color: _allValid() ? null : OlracColoursLight.olspsGrey,
          child: Text(
            'Save',
            style: Theme.of(context).textTheme.headline4,
          ),
          onPressed: _onPressSave,
        ),
      ],
    );
  }

  Widget _miniTextInput({String labelText, Function(String) onChanged}) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: OlracColoursLight.olspsExtraLightBlue,
        labelStyle: const TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogTitle = Text(
      'End Set Information',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle1,
    );

    final Widget dateTimeEditor = DateTimeEditor(
      title: 'Date and Time',
      initialDateTime: _endedAt,
      onChanged: (Picker picker, List<int> selectedIndices) {
        setState(() {
          _endedAt = DateTime.parse(picker.adapter.toString());
        });
      },
      titleStyle: Theme.of(context).textTheme.headline3,
      fieldColor: OlracColoursLight.olspsExtraLightBlue,
    );

    final Widget locationEditor = LocationEditor(
      subTitleStyle: Theme.of(context).textTheme.headline6,
      fieldColor: OlracColoursLight.olspsExtraLightBlue,
      title: 'Location',
      titleStyle: Theme.of(context).textTheme.headline3,
      location: _endLocation ?? Location(latitude: 0, longitude: 0),
      onChanged: (Location l) => setState(() => _endLocation = l),
    );

    final Widget setDuration = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set Duration',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Container(
            width: 200,
            child: Row(
              children: [
                Expanded(
                  child: _miniTextInput(labelText: 'Hours'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _miniTextInput(labelText: 'Minutes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final Widget hooksAndTraps = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Number of Hooks/Traps',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Container(
            width: 200,
            child: Row(
              children: [
                Expanded(
                  child: _miniTextInput(
                    labelText: 'Hooks',
                    onChanged: (String text) => setState(() => _hooks = text),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _miniTextInput(
                    labelText: 'Traps',
                    onChanged: (String text) => setState(() => _traps = text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final Widget linesUsed = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Max # of Lines Used',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Container(
            width: 100,
            child: _miniTextInput(
              labelText: 'Lines',
              onChanged: (String text) => setState(() => _linesUsed = text),
            ),
          ),
        ],
      ),
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            dialogTitle,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                dateTimeEditor,
                locationEditor,
                setDuration,
                hooksAndTraps,
                linesUsed,
                _saveButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
