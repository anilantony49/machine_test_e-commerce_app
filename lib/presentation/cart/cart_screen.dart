import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/alerts_and_navigators.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/widgets/custom_appbar1.dart';
import 'package:machine_test/widgets/image_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> cartItems = []; // Cart data stored here

  @override
  void initState() {
    super.initState();
    // You can initialize cartItems from a database or any other source
    // For example:
    // cartItems = CartDb().getCartItems();
  }

  // Method to update cart
  void updateCart(List<ProductModel> updatedCartItems) {
    setState(() {
      cartItems = updatedCartItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total amount
    // final double totalAmount = cartItems.fold(
    //   0.0,
    //   (sum, item) =>
    //       sum + (double.parse(item.price) * int.parse(item.quantity)),
    // );

    return Scaffold(
      appBar: CustomAppBar(title: AppText.myCart),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemBuilder: (context, index) {
                final item = cartItems[index]; // Get item data
                return ImageCart(
                  initialQuantity: 0,
                  title: item.title,
                  basePrice: 9.0,
                  image: item.image,
                  onRemove: () {
                    // // Update cart when an item is removed
                    // CartActions.removeItemsAndShowSnackbar(context, item.id);
                    // updateCart(cartItems); // Update cart after removal
                  },
                  unit: '',
                  id:'',
                  discount: '',
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black26,
                height: 1,
              ),
              itemCount: cartItems.length,
            ),
          ),
          // buildCheckOut(context, totalAmount)
        ],
      ),
    );
  }
}
