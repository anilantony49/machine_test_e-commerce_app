import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/colors.dart';
import 'package:machine_test/core/utils/constants.dart';

class CustomIconButton extends StatelessWidget {
  final int index;
  final ValueNotifier<int> indexChangeNotifier;
  final String assetImage;
  final String label;
  const CustomIconButton({
    super.key,
    required this.index,
    required this.indexChangeNotifier,
    required this.assetImage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, currentIndex, child) {
        final isSelected = currentIndex == index;
        return IconButton(
          enableFeedback: false,
          onPressed: () {
            indexChangeNotifier.value = index;
            FocusScope.of(context).unfocus();
          },
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetImage,
                height: 25,
                width: 25,
                color: isSelected ? Appcolor.primary : Appcolor.primaryText,
              ),
              kHeight(4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Appcolor.primary : Appcolor.primaryText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
