
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/text.dart';

class BuildProductCard extends StatelessWidget {
  final List products;
  const BuildProductCard({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        var product = products[index];
        return InkWell(
          // onTap: () {
          //   nextScreen(context, ProductDetailsScreen(product: product));
          // },
          child: Container(
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  // ignore: deprecated_member_use
                  color: Appcolor.placeholder.withOpacity(0.5),
                  width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${product["discount"]}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'product-icon-${product["name"]}', // Unique tag

                      child: Image.asset(
                        product["icon"]!,
                        width: 100,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product["name"]!,
                      style: TextStyle(
                          color: Appcolor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "${product["qty"]}${product["unit"]}",
                          style: TextStyle(
                              color: Appcolor.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${product["price"]}",
                          style: TextStyle(
                              color: Appcolor.primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        // ValueListenableBuilder(
                        //   valueListenable: CartDb.singleton.cartNotifier,
                        //   builder: (BuildContext context,
                        //       List<CartModels> cartItems, Widget? _) {
                        //     bool isItemInCart = cartItems.any((cartItem) =>
                        //         cartItem.title == product["name"]);
                        //     return InkWell(
                        //       onTap: () async {
                        //         // Check if the item is already in the cart
                        //         if (isItemInCart) {
                        //           // Remove item from cart
                        //           final cartItem = cartItems.firstWhere(
                        //               (cartItem) =>
                        //                   cartItem.title == product["name"]);
                        //           await CartDb.singleton
                        //               .removeCart(cartItem.id);

                        //           // ignore: use_build_context_synchronously
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //                 content: Text(AppText.itemRemovedText),
                        //                 duration: const Duration(seconds: 2)),
                        //           );
                        //         } else {
                        //           // Add item to cart
                        //           final newItem = CartModels(
                        //               id: DateTime.now()
                        //                   .millisecondsSinceEpoch
                        //                   .toString(),
                        //               title: product["name"],
                        //               price: product["price"],
                        //               quantity: product["qty"],
                        //               image: product["icon"],
                        //               unit: product["unit"],
                        //               discount: product["discount"]);

                        //           await CartDb.singleton.addCart(newItem);

                        //           // ignore: use_build_context_synchronously
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //                 content: Text(AppText.itemAddedText),
                        //                 duration: const Duration(seconds: 2)),
                        //           );
                        //         }
                        //       },
                        //       child: Container(
                        //         width: 34,
                        //         height: 34,
                        //         decoration: BoxDecoration(
                        //           color: Appcolor.primary,
                        //           borderRadius: BorderRadius.circular(15),
                        //         ),
                        //         alignment: Alignment.center,
                        //         child: Icon(
                        //           isItemInCart ? Icons.check : Icons.add,
                        //           color: Colors.white,
                        //           size: 20, // Adjust size as needed
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ); // Grid item widget
      },
    );
  }
}
