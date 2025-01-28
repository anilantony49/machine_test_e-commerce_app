import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);

// var mainFont = 'Coco-Gothic-Pro';
// const profileOne = 'assets/img/profile1.jpg';
// const profileTwo = 'assets/img/profile2.jpg';
// const profileThree = 'assets/img/profile3.jpg';
// const profileFour = 'assets/img/profile4.jpg';
// const profileFive = 'assets/img/profile5.jpg';
// const profilePlaceholder = 'assets/img/profile_placeholder.jpg';
// const privateIcon = 'assets/img/lock.png';

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
