import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/db/cart_db.dart';
import 'package:machine_test/presentation/cart/check_out_screen/check_out_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Calculate the total amount for the product
    // double totalAmount = product.price;
    // Define selectedProduct from the product map
    ProductModel selectedProduct = ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      quantity: product.quantity,
      image: product.image,
      // unit: product["unit"],
      // discount: product["discount"],
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.category!),
        backgroundColor: Appcolor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                product.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Appcolor.secondaryText,
                    fontWeight: FontWeight.bold),
              ),
              kHeight(15),
              Center(
                child: Hero(
                  tag:
                      'product-icon-${product.title}', // Same tag as in BuildProductCard

                  child: Image.network(
                    product.image,
                    width: 200,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green, // Green background for price
                      borderRadius: BorderRadius.circular(10), // Rounded edges
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  // kHeight(8),
                  // Star rating
                  Row(
                    children: List.generate(5, (index) {
                      if (index < product.rating!.rate.floor()) {
                        return const Icon(Icons.star,
                            color: Colors.amber, size: 20);
                      } else {
                        return const Icon(Icons.star_border,
                            color: Colors.amber, size: 20);
                      }
                    }),
                  ),
                  kWidth(10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red, // Background color for discount
                      borderRadius: BorderRadius.circular(12), // Rounded edges
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      product.rating!.rate.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white, // White text for contrast
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              kHeight(20),

              // Quantity Information
              Row(
                children: [
                  Text(
                    "Count: ${product.rating!.count}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Appcolor.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Product Description
              Text(
                textAlign: TextAlign.justify,
                product.description!,
                style: TextStyle(
                  fontSize: 18,
                  color: Appcolor.secondaryText,
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ValueListenableBuilder(
                    valueListenable: CartDb.singleton.cartNotifier,
                    builder: (BuildContext context,
                        List<ProductModel> cartItems, Widget? _) {
                      bool isItemInCart = cartItems
                          .any((cartItem) => cartItem.id == product.id);
                      return MaterialButton(
                        onPressed: () async {
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
                              quantity: product.quantity,
                              image: product.image,
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
                        minWidth: 100,
                        elevation: 0.1,
                        color: Appcolor.primary,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Text(
                          isItemInCart ? "Remove from cart" : "Add to cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      nextScreen(
                        context,
                        CheckOutScreen(
                          totalAmount: product.price,
                          product: selectedProduct,
                        ),
                      );
                    },
                    minWidth: 100,
                    elevation: 0.1,
                    color: Appcolor.primary,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
