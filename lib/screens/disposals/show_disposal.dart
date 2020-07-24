import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/disposal.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

Future<Map> _load(int disposalID) async {
  final Disposal disposal = await DisposalRepo().find(disposalID);
  final FishingSet fishingSet = await FishingSetRepo().find(disposal.fishingSetID);
  final Trip trip = await TripRepo().find(fishingSet.tripID);
  return {
    'disposal': disposal,
    'fishingSet': fishingSet,
    'trip': trip,
  };
}

class ShowDisposalScreen extends StatefulWidget {
  final int disposalID;
  final int indexID;

  const ShowDisposalScreen({this.disposalID, this.indexID});

  @override
  _ShowDisposalScreenState createState() => _ShowDisposalScreenState();
}

class _ShowDisposalScreenState extends State<ShowDisposalScreen> {
  Disposal _disposal;
  FishingSet _fishingSet;
  Trip _trip;

  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label: 'Trip ${_trip.id}',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(
          label: 'Set ${_fishingSet.id}',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(label: 'Disposal'),
        BreadcrumbElement(label: '#' + widget.indexID.toString()),
      ],
    );
  }

  Widget _disposalInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _disposal.species.commonName,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                DateFormat('yyyy/MMM/dd, kk:mm').format(_disposal.createdAt).toString(),
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

  Widget _dataTable() {
    final details = Column(children: [
      _dataRow('Common Name', _disposal.species.commonName),
      _dataRow('Species', _disposal.species.scientificName),
      _dataRow('Disposal State', _disposal.disposalState.name),

      _dataRow('Estimated Green Weight', (_disposal.estimatedGreenWeight / 1000).toString() + 'Kg'),
      _dataRow('Number of Individuals', _disposal.individuals.toString()),
//      _dataRow('Uploaded', _trip.isUploaded ? 'Yes' : 'No'),
    ]);

    return Expanded(
      child: SingleChildScrollView(
        child: details,
      ),
    );
  }

  Future<void> _onPressDelete() async {
    await DisposalRepo().delete(widget.disposalID);
    Navigator.pop(context);
  }

  Widget _body() {
    return Column(
      children: [
        _breadcrumb(),
        _disposalInfo(),
        const SizedBox(height: 15),
        _dataTable(),
        _bottomButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(widget.disposalID),
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold();
        }

        _disposal = snapshot.data['disposal'];
        _fishingSet = snapshot.data['fishingSet'];
        _trip = snapshot.data['trip'];

        return WestlakeScaffold(body: _body());
      },
    );
  }
}
