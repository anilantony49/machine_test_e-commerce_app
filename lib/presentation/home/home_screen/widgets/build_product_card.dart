import 'dart:math';

import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:machine_test/presentation/home/product_details_screen.dart/product_details_screen.dart';

class BuildProductCard extends StatelessWidget {
  final List<ProductModel> products; // Updated to use ProductModel
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
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return InkWell(
          onTap: () {
            nextScreen(context, ProductDetailsScreen(product: product));
          },
          child: Container(
            // height: 550,
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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product-icon-${product.title}', // Unique tag

                  child: Image.network(
                    product.image, // Use product image URL
                    width: 100,
                    height: 80,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
                const Spacer(),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  product.title, // Use product title
                  style: TextStyle(
                      color: Appcolor.primaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}", // Use product price
                      style: TextStyle(
                          color: Appcolor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    ValueListenableBuilder(
                      valueListenable: CartDb.singleton.cartNotifier,
                      builder: (BuildContext context,
                          List<ProductModel> cartItems, Widget? _) {
                        bool isItemInCart = cartItems
                            .any((cartItem) => cartItem.id == product.id);
                        return InkWell(
                          onTap: () async {
                            // Check if the item is already in the cart
                            if (isItemInCart) {
                              // Remove item from cart
                              final cartItem = cartItems.firstWhere(
                                  (cartItem) => cartItem.id == product.id);
                              await CartDb.singleton.removeCart(cartItem.id);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(AppText.itemRemovedText),
                                    duration: const Duration(seconds: 2)),
                              );
                            } else {
                              // Add item to cart
                              final newItem = ProductModel(
                                id: product.id,
                                title: product.title,
                                price: product.price,
                                // quantity: product.quantity,
                                image: product.image,
                                // unit: product["unit"],
                                // discount: product["discount"]
                              );

                              await CartDb.singleton.addCart(newItem);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(AppText.itemAddedText),
                                    duration: const Duration(seconds: 2)),
                              );
                            }
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Appcolor.primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              isItemInCart ? Icons.check : Icons.add,
                              color: Colors.white,
                              size: 20, // Adjust size as needed
                            ),
                          ),
                        );
                      },
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
