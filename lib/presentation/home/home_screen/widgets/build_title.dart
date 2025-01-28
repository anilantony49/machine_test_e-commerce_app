import 'package:flutter/material.dart';
import 'package:machine_test/widgets/section_view.dart';


Widget buildTitle({required String title}) {
    return SectionView(
      title: title,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      onPressed: () {},
    );
  }