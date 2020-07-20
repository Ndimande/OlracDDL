import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/screens/add_retained.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

class RetainedScreen extends StatefulWidget {
  @override
  _RetainedScreenState createState() => _RetainedScreenState();
}

class _RetainedScreenState extends State<RetainedScreen> {
  Widget _breadcrumb() {
    return Breadcrumb(
      elements: [
        BreadcrumbElement(label: 'Trip X', onPressed: () {
          // magnitude
          Navigator.pop(context);
          Navigator.pop(context);

        }),
        BreadcrumbElement(label: 'Set X', onPressed: () {
          Navigator.pop(context);
        }),
        BreadcrumbElement(label: 'Retained', onPressed: () {}),
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

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StripButton(
          labelText: 'Add Retained Catch',
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => AddRetainedScreen()));
          },
        )
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        _breadcrumb(),
        _noRetainedCatch(),
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
