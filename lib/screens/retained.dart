import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/screens/add_retained.dart';
import 'package:olracddl/screens/retained_info_screen.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';
import 'package:olracddl/widgets/circle_button.dart';

class RetainedScreen extends StatefulWidget {
  final int tripID, setID;

  const RetainedScreen({this.tripID, this.setID});

  @override
  _RetainedScreenState createState() => _RetainedScreenState();
}

class _RetainedScreenState extends State<RetainedScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(
          label: 'Trip ${widget.tripID}',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(label: 'Set ${widget.setID}'),
        BreadcrumbElement(label: 'Retained'),
      ],
    );
  }

  Widget _noRetainedCatch() {
    return Expanded(
      child: Center(
        child: Text(
          'No Retained Catch\nRecorded',
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
      DataColumn(label: Text('Species', style: headerStyle)),
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
            MaterialPageRoute(builder: (_) => RetainedInfoScreen(retainedCatchID: rc.id, indexID: i)),
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
        child: DataTable(
          columns: columns,
          rows: rows,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StripButton(
          labelText: 'Add Retained Catch',
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => AddRetainedScreen(widget.setID)));
            setState(() {});
          },
        )
      ],
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


