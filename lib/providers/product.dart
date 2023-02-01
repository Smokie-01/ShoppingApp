import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

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

  Future<void> toggleFavioriteStatus(String id) async {
    final oldStatus = isFavorite;
    try {
      final url =
          "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/products/$id.json";
      isFavorite = !isFavorite;
      final uri = Uri.parse(url);
      final response =
          await http.patch(uri, body: json.encode({"isFavorite": isFavorite}));
      notifyListeners();
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldStatus;
      print(e);
      notifyListeners();
    }
  }
}
