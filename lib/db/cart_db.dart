import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:machine_test/data/product_model.dart';

const _dbName = 'cartBox';

abstract class CartDbFunctions {
  Future<List<ProductModel>> getCart();
  Future<void> addCart(ProductModel models);
  Future<void> removeCart(int cartId);
  Future<void> editCart(ProductModel value, int cartId);
}

class CartDb implements CartDbFunctions {
  ValueNotifier<List<ProductModel>> cartNotifier = ValueNotifier([]);

  CartDb._internal() {
    refresh(); // Ensure cart data is loaded on app startup
  }
  static final CartDb singleton = CartDb._internal();

  factory CartDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allCart = await getCart();
    cartNotifier.value = List.from(allCart);
  }

  @override
  Future<void> addCart(ProductModel models) async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    await db.put(models.id, models);
    refresh();
  }

  @override
  Future<void> editCart(ProductModel value, int cartId) async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    await db.put(cartId, value);
    refresh();
  }

  @override
  Future<List<ProductModel>> getCart() async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    return db.values.toList();
    
  }

  @override
  Future<void> removeCart(int cartId) async {
    final db = await Hive.openBox<ProductModel>(_dbName);
    await db.delete(cartId);
     refresh();
  }
}
