
import 'package:flutter/material.dart';
import 'package:machine_test/others/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [];
  @override
  void initState() {
    pages = [];

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
