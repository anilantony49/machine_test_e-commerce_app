import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:machine_test/data/product_model.dart';

// Database name for storing cart data
const _dbName = 'cartBox';

abstract class CartDbFunctions {
  Future<List<ProductModel>> getCart(); // Fetch all cart items
  Future<void> addCart(ProductModel models); // Add a product to the cart
  Future<void> removeCart(
      int cartId); // Remove a product from the cart using its ID
  Future<void> editCart(
      ProductModel value, int cartId); // Edit an existing cart item
}

// Implementation of CartDbFunctions using Hive as a local database

class CartDb implements CartDbFunctions {
  // Notifier to update the UI when cart data changes
  ValueNotifier<List<ProductModel>> cartNotifier = ValueNotifier([]);
  // Private named constructor for singleton pattern
  CartDb._internal() {
    refresh(); // Ensure cart data is loaded on app startup
  }

  // Singleton instance of CartDb
  static final CartDb singleton = CartDb._internal();
// Factory constructor to return the same instance of CartDb
  factory CartDb() {
    return singleton;
  }
// Refresh cart data from the database and update cartNotifier
  Future<void> refresh() async {
    final allCart = await getCart();
    cartNotifier.value = List.from(allCart);
  }

  // Adds a product to the cart and updates the UI
  @override
  Future<void> addCart(ProductModel models) async {
    final db = await Hive.openBox<ProductModel>(_dbName); // Open the Hive box
    await db.put(models.id, models);
    refresh(); // Refresh cart data
  }

  // Edits an existing product in the cart and updates the UI
  @override
  Future<void> editCart(ProductModel value, int cartId) async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    await db.put(cartId, value);
    refresh();
  }

  // Retrieves all cart items from the database
  @override
  Future<List<ProductModel>> getCart() async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    return db.values.toList();
  }
  // Removes a product from the cart using its ID and updates the UI
  @override
  Future<void> removeCart(int cartId) async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    await db.delete(cartId);
    refresh();
  }
}
