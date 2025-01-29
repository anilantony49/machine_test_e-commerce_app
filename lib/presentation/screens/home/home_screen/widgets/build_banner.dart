import 'package:flutter/material.dart';

Widget buildBanner(PageController pageController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.maxFinite,
      height: 135,
      decoration: BoxDecoration(
          color: const Color(0xffF2F3F2),
          borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: PageView(
          controller: pageController,
          children: [
            Image.asset(
              "assets/img/banner1.jpeg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/banner2.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/banner3.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/banner4.jpg",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    ),
  );
}
