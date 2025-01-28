import 'package:flutter/material.dart';
import 'package:machine_test/presentation/cart/cart_screen/widgets/build_table_cell.dart';

Widget buildTableHeader() {
  return Table(
    border: TableBorder.all(color: Colors.black26),
    children: [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [
          buildTableCell('No'),
          buildTableCell('Name'),
          buildTableCell('Price (\$)'),
          buildTableCell('Qty'),
          // buildTableCell('Disc'),
          buildTableCell('Amount (\$)'),
        ],
      ),
    ],
  );
}
