import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/core/utils/alerts_and_navigators.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:machine_test/presentation/screens/home/product_details_screen.dart/product_details_screen.dart';

class BuildProductCard extends StatelessWidget {
  final List<ProductModel> products;

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
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Appcolor.placeholder.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Hero(
                  tag: 'product-icon-${product.title}',
                  child: Image.network(
                    product.image,
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
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Appcolor.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                kHeight(2),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        color: Appcolor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        bool isItemInCart = false;
                        if (state is CartLoadSucessState) {
                          isItemInCart = state.cartItems
                              .any((cartItem) => cartItem.id == product.id);
                        }

                        return InkWell(
                          onTap: () {
                            if (isItemInCart) {
                              context
                                  .read<CartBloc>()
                                  .add(CartRemove(product.id));
                              customSnackbar(context, AppText.itemRemovedText);
                            } else {
                              context.read<CartBloc>().add(CartAdd(product));
                              customSnackbar(context, AppText.itemAddedText);
                            
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
                              size: 20,
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
        );
      },
    );
  }
}
