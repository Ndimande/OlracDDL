import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olracddl/theme.dart';

class BreadcrumbElement {
  String label;
  VoidCallback onPressed;

  BreadcrumbElement({this.label, this.onPressed});
}

class Breadcrumb extends StatelessWidget {
  List<BreadcrumbElement> elements;
  TextStyle itemsTextStyle;

  Breadcrumb({this.elements, this.itemsTextStyle});

  List<Widget> breadcrumbItems;
  var index = 0;
  var indexTwo = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(vertical: 20),
      color: OlracColoursLight.olspsDarkBlue.shade100,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            ...breadcrumbItems = elements.map((BreadcrumbElement e) {
              index += 1;
              indexTwo += 1;
              return Row(
                children: [
                  if (index == 4)
                    SvgPicture.asset(
                      'assets/icons/image/arrow_darkblue_icon.svg',
                      height: 20,
                      width: 20,
                    ),
                  Container(
                    child: FlatButton(
                      color: Colors.transparent,
                      onPressed: e.onPressed,
                      child: Text(
                        e.label,
                        style: itemsTextStyle ?? Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                  if (index != 3 && index != 4)
                    SvgPicture.asset(
                      'assets/icons/image/arrow_darkblue_icon.svg',
                      height: 20,
                      width: 20,
                    ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
