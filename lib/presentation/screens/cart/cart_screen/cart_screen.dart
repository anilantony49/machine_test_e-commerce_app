import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/core/utils/alerts_and_navigators.dart';
import 'package:machine_test/core/utils/text.dart';
import 'package:machine_test/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:machine_test/widgets/custom_appbar1.dart';
import 'package:machine_test/widgets/image_cart.dart';
import 'package:machine_test/presentation/screens/cart/cart_screen/widgets/build_check_out.dart';
// import 'cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No need to provide CartBloc here since it's already provided in main.dart
    return Scaffold(
      appBar: CustomAppBar(title: AppText.myCart),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoadSucessState) {
            final cartItems = state.cartItems;
            final totalAmount = state.totalAmount;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    itemBuilder: (context, index) {
                      // Get item data
                      final item = cartItems[index];
                      return ImageCart(
                        initialQuantity: item.quantity ?? 1,
                        title: item.title,
                        basePrice: item.price,
                        image: item.image,
                        onRemove: () {
                          // Trigger CartRemove event using context.read
                          context.read<CartBloc>().add(CartRemove(item.id));
                          CartActions.removeItemsAndShowSnackbar(
                              context, item.id);
                        },
                        id: item.id,
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black26,
                      height: 1,
                    ),
                    itemCount: cartItems.length,
                  ),
                ),
                buildCheckOut(context, totalAmount)
              ],
            );
          } else if (state is CartErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return const Center(child: Text('Your cart is empty.'));
          }
        },
      ),
    );
  }
}
