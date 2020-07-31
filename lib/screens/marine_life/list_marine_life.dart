import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/marine_life.dart';
import 'package:olracddl/repos/marine_life.dart';
import 'package:olracddl/screens/marine_life/add_marine_life.dart';
import 'package:olracddl/screens/marine_life/show_marine_life.dart';

import 'package:olracddl/widgets/bread_crumb.dart';
import 'package:olracddl/widgets/circle_button.dart';

class ListMarineLifeScreen extends StatefulWidget {
  final int fishingSetID, tripID;

  const ListMarineLifeScreen({this.fishingSetID, this.tripID});

  @override
  _ListMarineLifeScreenState createState() => _ListMarineLifeScreenState();
}

class _ListMarineLifeScreenState extends State<ListMarineLifeScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label:
              '${AppLocalizations.of(context).getTranslatedValue('trip')} ${widget.tripID}',
          onPressed: () {
            // magnitude
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(
          label:
              '${AppLocalizations.of(context).getTranslatedValue('set')} ${widget.fishingSetID}',
        ),
        BreadcrumbElement(
            label:
                AppLocalizations.of(context).getTranslatedValue('marine_life'),
            onPressed: () {}),
      ],
    );
  }

  Widget _noMarineLife() {
    return Expanded(
      child: Center(
        child: Text(
          AppLocalizations.of(context)
              .getTranslatedValue('no_marine_life_recorded'),
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _marineLifeList(List<MarineLife> marineLifeList) {
    final headerStyle = Theme.of(context).textTheme.headline3;

    final List<DataColumn> columns = [
      DataColumn(label: Text('', style: headerStyle)),
      DataColumn(
          label: Text(
              AppLocalizations.of(context).getTranslatedValue('species'),
              style: headerStyle)),
      DataColumn(label: Text('Cond.', style: headerStyle), numeric: false),
      DataColumn(label: Text('Kg', style: headerStyle), numeric: false),
      DataColumn(label: Text('${AppLocalizations.of(context).getTranslatedValue('tag_number')}', style: headerStyle), numeric: false),
    ];

    int i = 1;
    final List<DataRow> rows = marineLifeList.map((MarineLife marineLife) {
      final button = CircleButton(
        text: (i).toString(),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ShowMarineLifeScreen(
                    marineLifeID: marineLife.id, indexID: i - 1)),
          );
          setState(() {});
        },
      );

      // increment list index
      i++;
      return DataRow(cells: [
        DataCell(button),
        DataCell(Text(marineLife.species.commonName)),
        DataCell(Text(marineLife.condition.name
            .substring(0, 1)
            .toUpperCase())), //need to check that this is correct
        DataCell(Text((marineLife.estimatedWeight / 1000).toString())),
        DataCell(Text(marineLife.tagNumber)),
      ]);
    }).toList();

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StripButton(
          labelText: AppLocalizations.of(context).getTranslatedValue('add_marine_life'),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddMarineLifeScreen(widget.fishingSetID)));
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: MarineLifeRepo()
          .all(where: 'fishing_set_id = ${widget.fishingSetID}'),
      builder: (context, AsyncSnapshot<List<MarineLife>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data.isEmpty) {
          return _noMarineLife();
        }

        return _marineLifeList(snapshot.data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      body: Column(
        children: [
          _breadcrumb(),
          _body(),
          _bottomButtons(),
        ],
      ),
    );
  }
}
