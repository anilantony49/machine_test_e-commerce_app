import 'package:flutter/material.dart';
import 'package:machine_test/widgets/custom_icon_button.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(0, -2))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomIconButton(
              index: 0,
              indexChangeNotifier: indexChangeNotifier,
              assetImage: "assets/img/store_tab.png",
              label: 'Shop',
            ),
            CustomIconButton(
              index: 1,
              indexChangeNotifier: indexChangeNotifier,
              assetImage: "assets/img/cart_tab.png",
              label: 'Cart',
            )
          ],
        ));
  }
}
