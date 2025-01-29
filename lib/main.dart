import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/others/main_screen.dart';
import 'package:machine_test/presentation/bloc/cart_bloc/cart_bloc.dart';
// import 'package:machine_test/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:machine_test/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:machine_test/presentation/screens/cart/cart_screen/cart_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(CartLoad()),
          child: CartScreen(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce app',
        theme: ThemeData(),
        home: MainScreen(),
      ),
    );
  }
}
