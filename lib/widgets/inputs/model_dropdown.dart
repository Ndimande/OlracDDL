import 'package:flutter/material.dart';

class DDLModelDropdown<T> extends StatelessWidget {
  final T selected;

  final Function(T) onChanged;

  final List<DropdownMenuItem<T>> items;

  final String label;

  final String hint;

  final Color fieldColor;

  final TextStyle labelStyle;

  final bool labelTheme;

  DDLModelDropdown({
    this.label,
    this.labelStyle,
    this.hint,
    this.fieldColor,
    @required this.selected,
    @required this.onChanged,
    @required this.items,
    this.labelTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null)
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Text(
                label,
                style: labelStyle ?? labelTheme
                    ? Theme.of(context).textTheme.headline2
                    : Theme.of(context).textTheme.headline3,
              ),
            ),
          Container(
            decoration: ShapeDecoration(
              color: fieldColor ?? Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<T>(
                  hint: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      hint ?? 'Tap to select',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  isExpanded: true,
                  style: Theme.of(context).textTheme.headline3,
                  value: selected,
                  onChanged: onChanged,
                  items: items,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//   items: <DropdownMenuItem>[
//     DropdownMenuItem(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15.0),
//             topRight: Radius.circular(15.0),
//           ),
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.green,
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       child: Container(
//         decoration: BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(15.0),
//           bottomRight: Radius.circular(15.0),
//         ),
//       ),
//     ),
//   ),
// ],
