import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/core/utils/text.dart';

Widget buildHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/img/location.png",
          width: 16,
          height: 16,
        ),
        kWidth(8),
        Text(
          AppText.address,
          style: TextStyle(
              color: Appcolor.darkGray,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        ClipOval(
          child: InkWell(
            child: Image.asset("assets/img/profile picture.webp",
                width: 55, height: 55, fit: BoxFit.cover),
          ),
        ),
      ],
    ),
  );
}
