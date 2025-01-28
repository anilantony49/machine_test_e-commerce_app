import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

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
  // final String category;
  @HiveField(4)
  final String image;
  // final Rating rating;
  @HiveField(5)
  final int? quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    // required this.category,
    required this.image,
    // required this.rating,
    this.quantity,
  });

  // Factory constructor to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      // category: json['category'],
      image: json['image'],
      // rating: Rating.fromJson(json['rating']),
    );
  }
}

// class Rating {
//   final double rate;
//   final int count;

//   Rating({
//     required this.rate,
//     required this.count,
//   });

//   // Factory constructor to create a Rating from JSON
//   factory Rating.fromJson(Map<String, dynamic> json) {
//     return Rating(
//       rate: json['rate'].toDouble(),
//       count: json['count'],
//     );
//   }
// }
