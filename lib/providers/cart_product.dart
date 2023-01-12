import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;

  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItemToCart(String productID, String title, double price) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID,
          (exsistingCartItem) => CartItem(
              id: exsistingCartItem.id,
              price: exsistingCartItem.price,
              quantity: exsistingCartItem.quantity,
              title: exsistingCartItem.title));
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
    }
    notifyListeners();
  }

  void removeCartItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void decreaseQuantity(String producID) {
    _items.update(
        producID,
        (exsistingCartItem) => CartItem(
            id: exsistingCartItem.id,
            price: exsistingCartItem.price,
            quantity: exsistingCartItem.quantity - 1,
            title: exsistingCartItem.title));
    notifyListeners();
  }

  void increaseQuantiy(String productID) {
    _items.update(
        productID,
        (exsistingCartItem) => CartItem(
            id: exsistingCartItem.id,
            price: exsistingCartItem.price,
            quantity: exsistingCartItem.quantity + 1,
            title: exsistingCartItem.title));
    notifyListeners();
  }

  void clearItems() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }
}
