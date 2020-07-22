import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/screens/add_retained.dart';
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

  Widget _catchListItem(RetainedCatch rc) {
    return Text(rc.species.commonName, style: Theme.of(context).textTheme.headline3);
  }

  Widget _catchList() {
    Future<List<RetainedCatch>> getRetainedCatch() async {
      return await RetainedCatchRepo().all(where: 'fishing_set_id = ${widget.setID}');
    }

    return FutureBuilder(
      future: getRetainedCatch(),
      builder: (context, AsyncSnapshot<List<RetainedCatch>> snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty) {
          return _noRetainedCatch();
        }

        final List<RetainedCatch> retainedCatchList = snapshot.data;

        return Column(children: retainedCatchList.map((RetainedCatch rc) => _catchListItem(rc)).toList());
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
          },
        )
      ],
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _breadcrumb(),
        Expanded(child: SingleChildScrollView(child: _catchList())),
        _bottomButtons(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      body: _body(),
    );
  }
}
