import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/presentation/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:machine_test/presentation/bloc/checkout_bloc/checkout_state.dart';
import 'package:machine_test/presentation/screens/cart/check_out_screen/widgets/build_summary_row.dart';
import 'package:machine_test/presentation/screens/cart/check_out_screen/widgets/build_table_body.dart';
import 'package:machine_test/presentation/screens/cart/check_out_screen/widgets/build_table_header.dart';
import 'package:machine_test/presentation/screens/cart/invoice_receipt/invoice_receipt_view.dart';
import 'package:machine_test/widgets/round_button.dart';

class CheckOutScreen extends StatelessWidget {
  final double totalAmount;
  final ProductModel? product;

  const CheckOutScreen({super.key, required this.totalAmount, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc()..add(FetchItemsEvent(product)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppText.checkOutTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutLoaded) {
              final items = state.items;
              final subtotal = state.subtotal;
              final double tax = 2.96;
              final double roundOff = 0.04;
              final double grandTotal = subtotal + tax + roundOff;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kHeight(15),
                      buildTableHeader(),
                      buildTableBody(items),
                      kHeight(15),
                      buildSummaryRow(
                          AppText.subtotal, '\$${subtotal.toStringAsFixed(2)}'),
                      kHeight(15),
                      buildSummaryRow(
                          AppText.tax, '\$${tax.toStringAsFixed(2)}'),
                      kHeight(15),
                      buildSummaryRow(
                          AppText.roundOff, '\$${roundOff.toStringAsFixed(2)}'),
                      kHeight(15),
                      buildSummaryRow(
                          AppText.total, '\$${grandTotal.toStringAsFixed(2)}',
                          fontSize: 25),
                      kHeight(25),
                      RoundButton(
                        title: AppText.buyNow,
                        onPressed: () {
                          nextScreen(
                              context,
                              InvoiceReceiptView(
                                grandTotal: grandTotal,
                                product: product,
                              ));
                        },
                      ),
                      kHeight(15),
                    ],
                  ),
                ),
              );
            } else if (state is CheckoutError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
