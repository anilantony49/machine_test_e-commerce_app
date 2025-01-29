import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);

Future<dynamic> nextScreen(context, page) {
  return Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

Future<dynamic> nextScreenReplacement(context, page) {
  return Navigator.pushReplacement(
      context, PageTransition(child: page, type: PageTransitionType.fade));
}

Future<dynamic> nextScreenRemoveUntil(context, page) {
  return Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}
