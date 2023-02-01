import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/providers/cart_product.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.totalAmount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrderItems(
      List<CartItem> cartProducts, double totalAmount) async {
    const url =
        "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
    Uri uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: json.encode({
            "totalAmount": totalAmount,
            "dateTime ": timeStamp.toIso8601String(),
            "products": cartProducts
                .map((items) => {
                      "id": items.id,
                      "title": items.title,
                      "price": items.price,
                      "quantity": items.quantity
                    })
                .toList()
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              totalAmount: totalAmount,
              products: cartProducts,
              dateTime: timeStamp));

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchOrders() async {
    var url =
        "https://shopping-app-1c5aa-default-rtdb.firebaseio.com/orders.json";
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final extractedOrder = jsonDecode(response.body) as Map<String, dynamic>;
      final List<OrderItem> orderedItems = [];

      extractedOrder.forEach(
        (id, oredrData) {
          orderedItems.add(OrderItem(
            id: id,
            totalAmount: oredrData['totalAmount'],
            dateTime: DateTime.now(),
            products: (oredrData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    id: id,
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title']))
                .toList(),
          ));
        },
      );
      _orders = orderedItems.reversed.toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
