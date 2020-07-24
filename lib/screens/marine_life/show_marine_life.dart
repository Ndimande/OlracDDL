import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/bread_crumb.dart';

class MarineLifeInfoScreen extends StatelessWidget {
  DataRow dataRow(BuildContext context, String variableHeader, String info) {
    return DataRow(cells: [
      DataCell(
        Text(
          variableHeader,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      DataCell(
        Text(
          info,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      body: Column(
        children: [
          Breadcrumb(elements: [
            BreadcrumbElement(label: 'Trip 1', onPressed: () {}),
            BreadcrumbElement(label: 'Set 1', onPressed: () {}),
            BreadcrumbElement(label: 'Marine Life', onPressed: () {}),
            BreadcrumbElement(label: '# 4', onPressed: () {}),
          ]),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Insert Title',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text('Insert Date and Time Info', style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Image.asset(
                      'assets/images/location_icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          DataTable(
            dividerThickness: 0,
            headingRowHeight: 0,
            columns: [
              const DataColumn(
                label: Text(''),
              ),
              const DataColumn(label: Text(''), numeric: true),
            ],
            rows: [
              dataRow(context, 'Common Name', 'inesrt'),
              dataRow(context, 'Species', 'inesrt'),
              dataRow(context, 'Condition', 'inesrt'),
              dataRow(context, 'Estimated Weight', 'inesrt'),
              dataRow(context, 'Tag Number', 'inesrt'),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StripButton(labelText: '     Edit     ', onPressed: () {}),
                  StripButton(labelText: '  Delete  ', color: OlracColoursLight.olspsRed, onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BackButton(),
            ],
          ),
        ),
      ],
    );
  }
}
