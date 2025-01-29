
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/text.dart';


Widget buildSearchBar(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      height: 52,
      decoration: BoxDecoration(
          color: const Color(0xffF2F3F2),
          borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Image.asset(
              "assets/img/search.png",
              width: 20,
              height: 20,
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: AppText.searchItem,
          hintStyle: TextStyle(
              color: Appcolor.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
