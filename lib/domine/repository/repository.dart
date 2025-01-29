import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:machine_test/data/product_model.dart';

class ProductRepository {
  // Base URL of the fake store API
  static const String _baseUrl = 'https://fakestoreapi.com';
  // Endpoint for fetching products
  static const String _productPath = '/products';

  // Fetch list of products
  static Future<List<ProductModel>> fetchProducts() async {
    try {
      // Sending a GET request to fetch products
      final response = await http.get(Uri.parse('$_baseUrl$_productPath'));

      // Handle HTTP response status codes
      if (response.statusCode == 200) {
        // If successful, decode the JSON response
        List<dynamic> data = json.decode(response.body);
        // Convert JSON data into a list of ProductModel objects
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        // If the endpoint is not found
        throw Exception('Products not found (404)');
      } else if (response.statusCode == 500) {
        // If there is a server error
        throw Exception('Server error (500)');
      } else {
        // Handle other status codes
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } on SocketException {
      // Handle network issues (e.g., no internet)
      throw Exception('No Internet connection. Please check your network.');
    } on FormatException {
      // Handle cases where the response format is incorrect
      throw Exception('Bad response format from the server.');
    } on TimeoutException {
      // Handle timeout scenarios
      throw Exception('The connection has timed out. Please try again.');
    } catch (e) {
      // Catch any other unexpected errors
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
