import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/repos/disposal.dart';
import 'package:olracddl/screens/disposals/add_disposal.dart';
import 'package:olracddl/screens/disposals/show_disposal.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';
import 'package:olracddl/widgets/circle_button.dart';

class ListDisposalsScreen extends StatefulWidget {
  final int fishingSetID, tripID;

  const ListDisposalsScreen({this.fishingSetID, this.tripID});

  @override
  _ListDisposalsScreenState createState() => _ListDisposalsScreenState();
}

class _ListDisposalsScreenState extends State<ListDisposalsScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label: '${AppLocalizations.of(context).getTranslatedValue('trip')} ${widget.tripID}',
          onPressed: () {
            // magnitude
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(
          label: '${AppLocalizations.of(context).getTranslatedValue('set')} ${widget.fishingSetID}',
        ),
        BreadcrumbElement(label: AppLocalizations.of(context).getTranslatedValue('disposals'), onPressed: () {}),
      ],
    );
  }

  Widget _noDisposals() {
    return Expanded(
      child: Center(
        child: Text(
          AppLocalizations.of(context).getTranslatedValue('no_disposals_recorded'),
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _disposalsList(List<Disposal> disposalList) {
    final headerStyle = Theme.of(context).textTheme.headline3;

    final List<DataColumn> columns = [
      DataColumn(label: Text('', style: headerStyle)),
      DataColumn(label: Text(AppLocalizations.of(context).getTranslatedValue('species'), style: headerStyle)),
      DataColumn(label: Text(AppLocalizations.of(context).getTranslatedValue('dis'), style: headerStyle), numeric: true),
      DataColumn(label: Text('Kg', style: headerStyle), numeric: true),
      DataColumn(label: Text('#', style: headerStyle), numeric: true),
    ];

    int i = 1;
    final List<DataRow> rows = disposalList.map((Disposal disposal) {
      final button = CircleButton(
        text: (i).toString(),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ShowDisposalScreen(disposalID: disposal.id, indexID: i-1)),
          );
          setState(() {});
        },
      );

      // increment list index
      i++;

      return DataRow(cells: [
        DataCell(button),
        DataCell(Text(disposal.species.commonName)),
        DataCell(Text(disposal.disposalState.name.substring(0, 1).toUpperCase())),
        DataCell(Text((disposal.estimatedGreenWeight / 1000).toString())),
        DataCell(Text(disposal.individuals.toString())),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StripButton(
            labelText: AppLocalizations.of(context).getTranslatedValue('add_disposal'),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => AddDisposalScreen(widget.fishingSetID)));
              setState(() {});
            },
          ),
            StripButton(
              color: OlracColoursLight.olspsRed,
            labelText: AppLocalizations.of(context).getTranslatedValue('save_and_exit'),
            onPressed: () =>  Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: DisposalRepo().all(where: 'fishing_set_id = ${widget.fishingSetID}'),
      builder: (context, AsyncSnapshot<List<Disposal>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data.isEmpty) {
          return _noDisposals();
        }

        return _disposalsList(snapshot.data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30,),
            onPressed: () => Navigator.pop(context),
          ),
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
