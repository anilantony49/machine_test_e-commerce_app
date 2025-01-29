
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/widgets/invoice_receipt_components.dart';
// import 'dart:io';

class BuildInvoicePdf extends StatelessWidget {
  final double grandTotal;
  final List<ProductModel> items;
  const BuildInvoicePdf(
      {super.key, required this.grandTotal, required this.items});
  @override
  Widget build(BuildContext context) {
    return buildBox(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.invoiceText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSmallButton('PDF', onPressed: (){}),
              _buildSmallButton('XPS', onPressed: () {}),
              _buildSmallButton('Print', onPressed: () {}),
            ],
          ),
        ],
      ),
      minHeight: 60,
      maxHeight: 90,
    );
  }

  Widget _buildSmallButton(String label, {required VoidCallback onPressed}) {
    return SizedBox(
      width: 80,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(label),
      ),
    );
  }
}
