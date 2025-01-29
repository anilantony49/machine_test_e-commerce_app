import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/presentation/bloc/cart_bloc/cart_bloc.dart';

class ImageCart extends StatelessWidget {
  final int id;
  final String title;
  final double basePrice;
  final int initialQuantity;
  final String image;
  final VoidCallback onRemove;

  const ImageCart({
    super.key,
    required this.id,
    required this.title,
    required this.basePrice,
    required this.initialQuantity,
    required this.image,
    required this.onRemove,
  });

  void _incrementQuantity(BuildContext context) {
    final updatedItem = ProductModel(
      id: id,
      title: title,
      price: basePrice,
      quantity: initialQuantity + 1,
      image: image,
    );
    context.read<CartBloc>().add(CartEdit(updatedItem));
  }

  void _decrementQuantity(BuildContext context) {
    if (initialQuantity > 1) {
      final updatedItem = ProductModel(
        id: id,
        title: title,
        price: basePrice,
        quantity: initialQuantity - 1,
        image: image,
      );
      context.read<CartBloc>().add(CartEdit(updatedItem));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(0.0, 10.0),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.multiply,
                ),
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          kWidth(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Appcolor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onRemove,
                      child: Image.asset(
                        "assets/img/close.png",
                        width: 15,
                        height: 15,
                        color: Appcolor.secondaryText,
                      ),
                    ),
                  ],
                ),
                kHeight(20),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _decrementQuantity(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Appcolor.placeholder.withOpacity(0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    kWidth(15),
                    Text(
                      "$initialQuantity Qty",
                      style: TextStyle(
                        color: Appcolor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    kWidth(15),
                    InkWell(
                      onTap: () => _incrementQuantity(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Appcolor.placeholder.withOpacity(0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$${(basePrice * initialQuantity).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Appcolor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
