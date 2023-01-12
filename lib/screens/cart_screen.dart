import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_product.dart' show Cart;
import 'package:shopapp/providers/orders_provider.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const namedRoute = "cart_screen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Chip(
                      label: Text(
                        "\$${cart.totalAmount.toInt()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    )
                  ]),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black12)),
              onPressed: () {
                Provider.of<Orders>(context, listen: false).addOrderItems(
                    cart.items.values.toList(), cart.totalAmount);
                cart.clearItems();
              },
              child: Text(
                "ORDER NOW",
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: ((context, index) => CartItem(
                      id: cart.items.values.toList()[index].id,
                      productID: cart.items.keys.toList()[index],
                      price: cart.items.values.toList()[index].price,
                      quantity: cart.items.values.toList()[index].quantity,
                      title: cart.items.values.toList()[index].title))))
        ],
      ),
    );
  }
}
