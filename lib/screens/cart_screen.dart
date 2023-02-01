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
                        "\$${cart.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                    )
                  ]),
            ),
          ),
          OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  OrderButton({
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isloading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black12)),
        onPressed: (widget.cart.totalAmount <= 0 || isloading)
            ? null
            : () async {
                setState(() {
                  isloading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrderItems(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                widget.cart.clearItems();
                setState(() {
                  isloading = false;
                });
              },
        child: isloading
            ? Center(child: CircularProgressIndicator())
            : Text(
                "ORDER NOW",
              ));
  }
}
