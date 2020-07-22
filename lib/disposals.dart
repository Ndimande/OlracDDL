import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/screens/add_disposal.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

class DisposalsScreen extends StatefulWidget {
  final int fishingSetID, tripID;
  const DisposalsScreen({this.fishingSetID,this.tripID});

  @override
  _DisposalsScreenState createState() => _DisposalsScreenState();
}

class _DisposalsScreenState extends State<DisposalsScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(label: 'Trip ${widget.tripID}', onPressed: () {
          // magnitude
          Navigator.pop(context);
          Navigator.pop(context);

        }),
        BreadcrumbElement(label: 'Set ${widget.fishingSetID}', onPressed: () {
          Navigator.pop(context);
        }),
        BreadcrumbElement(label: 'Disposals', onPressed: () {}),
      ],
    );
  }

  Widget _noDisposals() {
    return Expanded(
      child: Center(
        child: Text(
          'No Disposals Recorded',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StripButton(
          labelText: 'Add Disposal',
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => AddDisposalScreen()));
          },
        )
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        _breadcrumb(),
        _noDisposals(),
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