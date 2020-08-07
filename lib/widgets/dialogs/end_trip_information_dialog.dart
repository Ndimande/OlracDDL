import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/island.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/repos/island.dart';
import 'package:olracddl/repos/port.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/location_editor.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

class EndTripInformationDialog extends StatefulWidget {
  @override
  _EndTripInformationDialogState createState() =>
      _EndTripInformationDialogState();
}

class _EndTripInformationDialogState extends State<EndTripInformationDialog> {
  Location _location;

  DateTime _endedAt = DateTime.now();

  Island _island;

  Port _port;

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

  Widget _islandNotSelected() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).getTranslatedValue('departure_port'),
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 5),
          Container(
            height: 51,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                fillColor: OlracColoursLight.olspsExtraLightBlue,
                hintStyle: Theme.of(context).textTheme.bodyText2,
                hintText: '   *Waiting on Island Selection',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _islandDropdown() {
    Future<List<Island>> getIslands() async => IslandRepo().all();
    return FutureBuilder(
      future: getIslands(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const TextField();
        }
        final List<Island> islands = snapshot.data;

        return DDLModelDropdown<Island>(
          fieldColor: OlracColoursLight.olspsExtraLightBlue,
          labelTheme: false,
          selected: _island,
          label: 'Departure Island',
          onChanged: (Island islands) => setState(() => _island = islands),
          items: islands.map<DropdownMenuItem<Island>>((Island island) {
            return DropdownMenuItem<Island>(
              value: island,
              child: Text(
                island.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _portDropdown() {
    Future<List<Port>> getPorts() async =>
        PortRepo().all(where: 'island_id = ${_island.id}');
    return FutureBuilder(
      future: getPorts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const TextField();
        }
        final List<Port> ports = snapshot.data;

        return DDLModelDropdown<Port>(
          fieldColor: OlracColoursLight.olspsExtraLightBlue,
          labelTheme: false,
          selected: _port,
          label:
              AppLocalizations.of(context).getTranslatedValue('departure_port'),
          onChanged: (Port port) => setState(() => _port = port),
          items: ports.map<DropdownMenuItem<Port>>((Port port) {
            return DropdownMenuItem<Port>(
              value: port,
              child: Text(
                port.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          }).toList(),
        );
      },
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
              AppLocalizations.of(context)
                  .getTranslatedValue('end_trip_information'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            _dateAndTime(),
            _locationInput(),
            const SizedBox(height: 5),
            _islandDropdown(),
            (_island == null) ? _islandNotSelected() : _portDropdown(),
            const SizedBox(height: 15),
            _saveButton()
          ],
        ),
      ),
    );
  }
}
