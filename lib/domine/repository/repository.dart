import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:machine_test/data/product_model.dart';

class ProductRepository {
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _productPath = '/products';

  // Fetch list of products
  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl$_productPath'));

      // Handle HTTP response status codes
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('Products not found (404)');
      } else if (response.statusCode == 500) {
        throw Exception('Server error (500)');
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection. Please check your network.');
    } on FormatException {
      throw Exception('Bad response format from the server.');
    } on TimeoutException {
      throw Exception('The connection has timed out. Please try again.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
