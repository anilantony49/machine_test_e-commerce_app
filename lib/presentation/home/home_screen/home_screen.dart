import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/core/utils/constants.dart';
import 'package:machine_test/data/product_model.dart';
import 'package:machine_test/domine/repository/repository.dart';
import 'package:machine_test/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:machine_test/presentation/home/home_screen/widgets/build_banner.dart';
import 'package:machine_test/presentation/home/home_screen/widgets/build_header.dart';
import 'package:machine_test/presentation/home/home_screen/widgets/build_product_card.dart';
import 'package:machine_test/presentation/home/home_screen/widgets/build_search_bar.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Automatically change pages every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 4;
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    context.read<ProductBloc>().add(FetchProductsEvent());
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Fetch product data from the API
  // Future<List<ProductModel>> fetchProducts() async {
  //   try {
  //     return await ProductRepository.fetchProducts();
  //   } catch (e) {
  //     throw Exception('Failed to fetch products: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeader(context),
              const SizedBox(
                height: 15,
              ),
              buildSearchBar(txtSearch),
              const SizedBox(
                height: 15,
              ),
              buildBanner(pageController),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: ExpandingDotsEffect(
                  activeDotColor: Appcolor.primary,
                  dotColor: Appcolor.secondaryText,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2,
                ),
              ),
              // buildTitle(),
              kHeight(20),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductErrorState) {
                    return Center(child: Text('Error: something went wrong'));
                  } else if (state is ProductSucessState) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No products available'));
                    }
                    return BuildProductCard(products: state.products);
                  }
                  return const SizedBox.shrink();
                },
              ),
              // FutureBuilder(
              //   future: fetchProducts(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     } else if (snapshot.hasError) {
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //       return const Center(child: Text('No products available'));
              //     } else {
              //       // Pass the product data to BuildProductCard
              //       return BuildProductCard(products: snapshot.data!);
              //     }
              //   },
              // ),
              //  kHeight(90)
              // buildTitle(),
              // BuildProductCard(
              //     // products: groceries,
              //     ),
              // const SizedBox(
              //   height: 15,
              // ),
              // buildTitle(),
              // BuildProductCard(
              //     // products: fruits,
              //     ),
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        )));
  }
}
