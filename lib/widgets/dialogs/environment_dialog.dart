import 'dart:math';

import 'package:database_repo/database_repo.dart';
import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';

class EnvironmentDialog extends StatefulWidget {
  const EnvironmentDialog({
    Key key,
    @required this.title,
    @required this.models,
  }) : super(key: key);

  final String title;
  final List<Model> models;

  @override
  _EnvironmentDialogState createState() => _EnvironmentDialogState();
}

class _EnvironmentDialogState extends State<EnvironmentDialog> {
  String get _title => widget.title;

  List<Model> get _models => widget.models;

  Model _currentModel;

  @override
  void initState() {
    super.initState();
    _currentModel = _models[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(
              child: Text(
                _title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Center(
              child: Text(
                _currentModel.toMap()['name'],
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: IconButton(
                      icon: Transform.rotate(
                        child: Image.asset(
                          _models[0] == _currentModel
                              ? 'assets/images/arrow_grey.png'
                              : 'assets/images/arrow_darkBlue.png',
                        ),
                        angle: pi,
                      ),
                      onPressed: _models[0] == _currentModel ? null : _previousItem,
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        child: Image.asset(
                          _currentModel.toMap()['imageString'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.6,
                    child: IconButton(
                      icon: Image.asset(
                        _models.last == _currentModel
                            ? 'assets/images/arrow_grey.png'
                            : 'assets/images/arrow_darkBlue.png',
                      ),
                      onPressed: _models.last == _currentModel ? null : _nextItem,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        
        StripButton(
          labelText: ' Confirm ',
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.of(context).pop(_currentModel);
          },
          disabled: false,
        ),
        StripButton(
          labelText: '  Cancel  ',
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
       const SizedBox(width: 18),
      ],
    );
  }

  void _nextItem() {
    setState(() {
      _currentModel = _models[_models.indexOf(_currentModel) + 1];
    });
  }

  void _previousItem() {
    setState(() {
      _currentModel = _models[_models.indexOf(_currentModel) - 1];
    });
  }
}
