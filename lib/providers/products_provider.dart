import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red T-Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Iphone 14 pro',
      description:
          'Buy the Apple iPhone 14 Pro Max 128 GB (Deep Purple, 6 GB RAM)',
      price: 499.99,
      imageURL:
          'https://img1.gadgetsnow.com/gd/images/products/additional/large/G390852_View_1/mobiles/smartphones/apple-iphone-14-pro-max-128-gb-deep-purple-6-gb-ram-.jpg',
    ),
  ];

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

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        description: product.description,
        price: product.price,
        title: product.title,
        imageURL: product.imageURL);
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product product) {
    final newProductIndex = _items.indexWhere((prod) => prod.id == id);
    if (newProductIndex >= 0) {
      _items[newProductIndex] = product;
      notifyListeners();
    }
  }
}
