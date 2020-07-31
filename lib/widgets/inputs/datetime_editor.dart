import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/localization/app_localization.dart';

class DateTimeEditor extends StatelessWidget {
  final DateTime initialDateTime;
  final Function onChanged;
  final String title;
  final TextStyle titleStyle;
  final Color fieldColor;

  const DateTimeEditor({
    @required this.title,
    @required this.initialDateTime,
    @required this.onChanged,
    this.titleStyle,
    this.fieldColor,
  })  : assert(title != null),
        assert(initialDateTime != null),
        assert(onChanged != null);

  void _onPressEditStartDateTime(BuildContext context) {
    final adapter = DateTimePickerAdapter(
      type: PickerDateTimeType.kYMDHM,
      value: initialDateTime,
      maxValue: DateTime.now(),
      minValue: DateTime.now().subtract(const Duration(days: 500)),
    );

    Picker(
      selecteds: [],
      adapter: adapter,
      title: Container(
        child: Text(
          AppLocalizations.of(context).getTranslatedValue('date_and_time'),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      onConfirm: (Picker picker, List<int> selectedIndices) => onChanged(picker, selectedIndices),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: fieldColor ?? Colors.white, borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => _onPressEditStartDateTime(context),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    friendlyDateTime(initialDateTime),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
