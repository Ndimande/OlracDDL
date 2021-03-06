import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/screens/retained/add_retained.dart';
import 'package:olracddl/screens/retained/show_retained.dart';
import 'package:olracddl/widgets/bread_crumb.dart';
import 'package:olracddl/widgets/circle_button.dart';

import '../../theme.dart';

class ListRetainedScreen extends StatefulWidget {
  final int tripID, setID;

  const ListRetainedScreen({this.tripID, this.setID});

  @override
  _ListRetainedScreenState createState() => _ListRetainedScreenState();
}

class _ListRetainedScreenState extends State<ListRetainedScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label: '${AppLocalizations.of(context).getTranslatedValue('trip')} ${widget.tripID}',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(label: '${AppLocalizations.of(context).getTranslatedValue('set')} ${widget.setID}'),
        BreadcrumbElement(label: AppLocalizations.of(context).getTranslatedValue('retained')),
      ],
    );
  }

  Widget _noRetainedCatch() {
    return Expanded(
      child: Center(
        child: Text(
          AppLocalizations.of(context).getTranslatedValue('no_retained_catch_recorded'),
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _catchList(List<RetainedCatch> retainedCatchList) {
    final headerStyle = Theme.of(context).textTheme.headline3;

    final List<DataColumn> columns = [
      DataColumn(label: Text('', style: headerStyle)),
      DataColumn(label: Text(AppLocalizations.of(context).getTranslatedValue('species'), style: headerStyle)),
      DataColumn(label: Text('Kg', style: headerStyle), numeric: true),
      DataColumn(label: Text('#', style: headerStyle), numeric: true),
    ];

    int i = 1;
    final List<DataRow> rows = retainedCatchList.map((RetainedCatch rc) {
      final button = CircleButton(
        text: (i).toString(),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ShowRetainedScreen(retainedCatchID: rc.id, indexID: i-1)),
          );
          setState(() {});
        },
      );

      // increment list index
      i++;

      return DataRow(cells: [
        DataCell(button),
        DataCell(Text(rc.species.commonName)),
        DataCell(Text((rc.greenWeight / 1000).toString())),
        DataCell(Text(rc.individuals.toString())),
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

  Widget _body() {
    return FutureBuilder(
      future: RetainedCatchRepo().all(where: 'fishing_set_id = ${widget.setID}'),
      builder: (context, AsyncSnapshot<List<RetainedCatch>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data.isEmpty) {
          return _noRetainedCatch();
        }

        final List<RetainedCatch> retainedCatchList = snapshot.data;

        return _catchList(retainedCatchList);
      },
    );
  }

  Widget _bottomButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StripButton(
            labelText: AppLocalizations.of(context).getTranslatedValue('add_catch'),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => AddRetainedScreen(widget.setID)));
              setState(() {});
            },
          ),
          StripButton(
              color: OlracColoursLight.olspsRed,
            labelText: AppLocalizations.of(context).getTranslatedValue('save_and_exit'),
            onPressed: () =>  Navigator.pop(context),
          ),
        ],
      ),
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
