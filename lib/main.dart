import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/others/main_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce app',
      theme: ThemeData(),
      home: MainScreen(),
    );
  }
}
