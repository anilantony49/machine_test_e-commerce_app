import 'package:flutter/material.dart';

Widget buildTableCell(String text,
    {double fontSize = 14,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign textAlign = TextAlign.center}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    ),
  );
}
