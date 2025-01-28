import 'package:flutter/material.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/presentation/cart/cart_screen/widgets/build_table_cell.dart';

Widget buildTableBody(List<ProductModel> items) {
  return Table(
    border: TableBorder.all(color: Colors.black12),
    children: items.asMap().entries.map((entry) {
      int index = entry.key;
      ProductModel item = entry.value;

      double price = item.price;
      int quantity = item.quantity??1;
      // double discount = double.tryParse(item.discount) ?? 0.0;
      double totalPrice = (price * quantity);

      return TableRow(
        children: [
          buildTableCell('${index + 1}', fontWeight: FontWeight.w400),
          buildTableCell(item.title, fontWeight: FontWeight.w400),
          buildTableCell(item.price.toString(), fontWeight: FontWeight.w400),
          buildTableCell(item.quantity.toString(), fontWeight: FontWeight.w400),
          // buildTableCell(discount.toStringAsFixed(2),
          //     fontWeight: FontWeight.w400),
          buildTableCell(totalPrice.toStringAsFixed(2),
              fontWeight: FontWeight.w400),
        ],
      );
    }).toList(),
  );
}
