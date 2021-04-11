import 'package:flutter/material.dart';

Widget entryBuilder(String label, var data, String unit, BuildContext context,
    BoxConstraints constraints) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 40,
          width: ((constraints.maxWidth / 2) - 10),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          // constraints: BoxConstraints.tight(Size(200, 50)),
          // decoration: BoxDecoration(color: Color(0xff00e5f7)),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              key: Key('Field Label'),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, height: 0.1),
            ),
          ),
        ),
        Container(
          height: 40,
          width: ((constraints.maxWidth / 2) - 50),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          // constraints: BoxConstraints.tight(Size(70, 50)),
          // decoration: BoxDecoration(color: Color(0xffd7e5f7)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$data $unit',
              key: Key('Current Entry'),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 18, height: 0.1),
            ),
          ),
        ),
      ]);
}

/// Flutter's concept of page navigation requires creating some boilerplate
/// for each page (route?), which we do not want to do. This helper will do
/// this in a consistent manner.
Widget wrapRoute(Widget widget, String title) {
  return Scaffold(
    body: widget,
    appBar: AppBar(
      title: Text(title),
    ),
  );
}
