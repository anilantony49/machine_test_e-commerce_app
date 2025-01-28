  import 'package:flutter/material.dart';

Widget buildAnimatedImage(Animation<double> scaleAnimation) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Image.asset(
        "assets/img/order_accpeted.png",
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }