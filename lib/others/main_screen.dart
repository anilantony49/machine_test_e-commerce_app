
import 'package:flutter/material.dart';
import 'package:machine_test/others/bottom_navigation.dart';
import 'package:machine_test/presentation/cart/cart_screen/cart_screen.dart';
import 'package:machine_test/presentation/home/home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 List<Widget> pages = [];
  @override  @override
  void initState() {
    pages = [const HomeScreen(), const CartScreen()];


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, child) {
            return IndexedStack(
              index: index,
              children: pages,
            );
          }),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
