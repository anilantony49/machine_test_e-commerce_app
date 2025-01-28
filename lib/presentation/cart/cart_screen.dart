import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/alerts_and_navigators.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:machine_test/presentation/cart/widgets/build_check_out.dart';
import 'package:machine_test/widgets/custom_appbar1.dart';
import 'package:machine_test/widgets/image_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppText.myCart),
      body: ValueListenableBuilder(
        valueListenable: CartDb().cartNotifier,
        builder: (BuildContext context, List<ProductModel> newItem, Widget? _) {
          // calculate total amount
          final double totalAmount = newItem.fold(
              0.0, (sum, item) => sum + ((item.price * item.quantity!)));
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  itemBuilder: (context, index) {
                    // Get item data
                    final item = newItem[index];
                    return ImageCart(
                      initialQuantity: 1,
                      title: item.title,
                      basePrice: item.price,
                      image: item.image,
                      onRemove: () => CartActions.removeItemsAndShowSnackbar(
                          context, item.id),
                      // unit: item.id.toString(),
                      id: item.id,
                      // discount: item.discount,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  itemCount: newItem.length,
                ),
              ),
              buildCheckOut(context, totalAmount)
            ],
          );
        },
      ),
    );
  }
}
