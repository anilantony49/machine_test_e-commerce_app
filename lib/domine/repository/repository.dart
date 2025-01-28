import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_test/data/product_model.dart';

class ProductRepository {
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _productPath = '/products';

  // Fetch list of products
  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl$_productPath'));

      // Check for success response
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
