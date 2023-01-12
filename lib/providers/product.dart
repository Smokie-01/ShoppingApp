import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  late final String title;
  final String description;
  final double price;
  final String imageURL;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.price,
      this.isFavorite = false});

  void toggleFavioriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
