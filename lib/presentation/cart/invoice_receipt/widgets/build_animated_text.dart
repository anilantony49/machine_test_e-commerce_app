
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/text.dart';

Widget buildAnimatedText() {
  return AnimatedTextKit(
    animatedTexts: [
      ColorizeAnimatedText(
        AppText.billedSuccessfully,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        colors: [
          Colors.green,
          Colors.blue,
          Colors.orange,
          Colors.purple,
        ],
      ),
    ],
    isRepeatingAnimation: true,
    repeatForever: true,
  );
}
