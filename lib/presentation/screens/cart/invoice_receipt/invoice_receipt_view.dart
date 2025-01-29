import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:machine_test/presentation/screens/cart/check_out_screen/widgets/build_table_body.dart';
import 'package:machine_test/presentation/screens/cart/check_out_screen/widgets/build_table_header.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/widgets/build_animated_image.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/widgets/build_animated_text.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/widgets/build_invoice_pdf.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/widgets/invoice_receipt_components.dart';

class InvoiceReceiptView extends StatefulWidget {
  final double grandTotal;
  final ProductModel? product;
  const InvoiceReceiptView({super.key, required this.grandTotal, this.product});

  @override
  State<InvoiceReceiptView> createState() => _InvoiceReceiptViewState();
}

class _InvoiceReceiptViewState extends State<InvoiceReceiptView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  List<ProductModel> items = [];

  @override
  void initState() {
    _fetchItems();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _fetchItems() async {
    if (widget.product != null) {
      // If a single product is passed, display only that
      setState(() {
        items = [widget.product!]; // Add the single product to the list
      });
    } else {
      // If no product is passed, fetch all items from the cart
      List<ProductModel> fetchedItems = await CartDb.singleton.getCart();
      setState(() {
        items = fetchedItems;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildAnimatedImage(scaleAnimation),
                 kHeight(20),
                buildAnimatedText(),
                  kHeight(20),
                const DetailsBox(
                  label1: 'Order Number',
                  value1: 'CTR362',
                  label2: 'Bill Number',
                  value2: 'S178',
                ),
               kHeight(10),
                SummaryBox(
                  title: 'Payment Summary',
                  label: 'Cash',
                  value: "\$${widget.grandTotal.toStringAsFixed(2)}",
                ),
                kHeight(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product details',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    buildTableHeader(),
                    buildTableBody(items),
                  ],
                ),
                 kHeight(20),
                DetailsBox(
                  label1: 'Total amount paid',
                  value1: "\$${widget.grandTotal.toStringAsFixed(2)}",
                  label2: 'Remaining amount to be paid',
                  value2: '\$0',
                ),
                kHeight(10),
                const CustomerInfoBox(),
                kHeight(20),
                BuildInvoicePdf(
                  grandTotal: widget.grandTotal,
                  items: items,
                ),
                kHeight(20),
                ActionButton(
                  label: 'New sale',
                  onPressed: () {
                    // Handle New Sale action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
