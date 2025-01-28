// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Appcolor.appBarColor,
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Appcolor.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
