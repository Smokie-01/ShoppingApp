import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';

import 'product.dart';

const url =
    "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/products.json";

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
    // The Three dots are used for only returning the copy of items not the real list of items
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) async {
    Uri uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageURL": product.imageURL,
            "isFavorite": product.isFavorite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          price: product.price,
          title: product.title,
          imageURL: product.imageURL);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final url =
        "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/products/$id.json";
    final newProductIndex = _items.indexWhere((prod) => prod.id == id);

    if (newProductIndex >= 0) {
      Uri uri = Uri.parse(url);
      await http.patch(uri,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "ImageURL": product.imageURL,
          }));

      _items[newProductIndex] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String productID) async {
    final url =
        "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/products/$productID.json";
    final uri = Uri.parse(url);
    final exsistingProductIndex =
        _items.indexWhere((prod) => prod.id == productID);
    var exsistingProduct = _items[exsistingProductIndex];
    _items.removeAt(exsistingProductIndex);
    notifyListeners();
    final response = await http.delete(uri);

    if (response.statusCode >= 400) {
      _items.insert(exsistingProductIndex, exsistingProduct);
      notifyListeners();
      throw HttpException("Could not able to delete product");
    }
  }

  Future<void> fetchData() async {
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      if (extractedData == null) {
        return null;
      }
      extractedData.forEach((prodID, prodData) {
        loadedProduct.add(Product(
            id: prodID,
            title: prodData["title"],
            description: prodData["description"],
            imageURL: prodData["imageURL"],
            price: prodData["price"],
            isFavorite: prodData["isFavorite"]));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
