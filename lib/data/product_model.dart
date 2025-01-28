import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';
// part 'rating.g.dart'; 

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final int? quantity;
  @HiveField(6)
  final String? category;
  @HiveField(7)
  final Rating? rating;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      this.description,
      required this.image,
      this.rating,
      this.quantity = 1,
      this.category});

  // Factory constructor to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

@HiveType(typeId: 2)
class Rating {
  @HiveField(0)
  final double rate;
  @HiveField(1)
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  // Factory constructor to create a Rating from JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}
