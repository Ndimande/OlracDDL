import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

Future<Map> _load(int retainedCatchID) async {
  final RetainedCatch retainedCatch = await RetainedCatchRepo().find(retainedCatchID);
  final FishingSet fishingSet = await FishingSetRepo().find(retainedCatch.fishingSetID);
  final Trip trip = await TripRepo().find(fishingSet.tripID);
  return {
    'retainedCatch': retainedCatch,
    'fishingSet': fishingSet,
    'trip': trip,
  };
}

class ShowRetainedScreen extends StatefulWidget {
  final int retainedCatchID;
  final int indexID;

  const ShowRetainedScreen({this.retainedCatchID, this.indexID});

  @override
  _ShowRetainedScreenState createState() => _ShowRetainedScreenState();
}

class _ShowRetainedScreenState extends State<ShowRetainedScreen> {
  RetainedCatch _retainedCatch;
  FishingSet _fishingSet;
  Trip _trip;

  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label: 'Trip ${_trip.id}',
          onPressed: () {
            // magnitude
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(
          label: 'Set ${_fishingSet.id}',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(label: 'Retained'),
        BreadcrumbElement(label: widget.indexID.toString()),
      ],
    );
  }

  Widget _dataRow(String variableHeader, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(variableHeader, style: Theme.of(context).textTheme.headline2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(info, style: Theme.of(context).textTheme.headline3),
        ),
      ]),
    );
  }

  Widget _catchInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _retainedCatch.species.commonName,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                DateFormat('yyyy/MMM/dd, kk:mm').format(_retainedCatch.createdAt).toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Image.asset(
                'assets/images/location_icon.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataTable() {
    final details = Column(children: [
      _dataRow('Common Name', _retainedCatch.species.commonName),
      _dataRow('Species', _retainedCatch.species.scientificName),
      _dataRow('Green Weight', (_retainedCatch.greenWeight / 1000).toString()),
      _dataRow('No. of Individuals', _retainedCatch.individuals.toString()),
      _dataRow('Uploaded', _trip.isUploaded ? 'Yes' : 'No'),
    ]);

    return Expanded(
      child: SingleChildScrollView(
        child: details,
      ),
    );
  }

  Future<void> _onPressEdit() async {
    // go to edit screen
  }

  Future<void> _onPressDelete() async {
    await RetainedCatchRepo().delete(widget.retainedCatchID);
    Navigator.pop(context);
  }

  Widget _bottomButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const StripButton(
            labelText: 'Edit',
            onPressed: null,
            color: OlracColoursLight.olspsGrey,
          ),
          StripButton(
            labelText: 'Delete',
            onPressed: _onPressDelete,
            color: OlracColoursLight.olspsRed,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _breadcrumb(),
        _catchInfo(),
        const SizedBox(height: 15),
        _dataTable(),
        _bottomButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(widget.retainedCatchID),
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold();
        }

        _retainedCatch = snapshot.data['retainedCatch'];
        _fishingSet = snapshot.data['fishingSet'];
        _trip = snapshot.data['trip'];

        return WestlakeScaffold(
          body: _body(),
        );
      },
    );
  }
}
