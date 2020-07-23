import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/screens/add_retained.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

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
            // magnitude
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        BreadcrumbElement(
          label: 'Set ${widget.setID}',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      return DataRow(cells: [
        DataCell(CircleButton(
          text: (i++).toString(),
          onTap: () {print('test');},
        )),
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

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;

  const CircleButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 35.0;

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(color: OlracColoursLight.olspsDarkBlue, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.only(top:6,left:12),
          child: Text(text,style: Theme.of(context).primaryTextTheme.headline6),
        ),
      ),
    );
  }
}
