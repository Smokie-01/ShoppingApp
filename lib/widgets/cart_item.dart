import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_product.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.productID,
      required this.price,
      required this.quantity,
      required this.title});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Are you sure?"),
                  content:
                      Text("Do you want to remove this item from the cart."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Yes")),
                  ],
                ));
      },
      onDismissed: (direction) {
        cart.removeCartItem(productID);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: FittedBox(child: Text("\$$price")),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity).toInt()}"),
            trailing: Wrap(children: [
              Text(
                "${quantity} x",
              ),
              IconButton(
                  onPressed: () {
                    cart.decreaseQuantity(productID);
                  },
                  icon: Icon(Icons.remove_circle_outline_rounded)),
              IconButton(
                  onPressed: () {
                    cart.increaseQuantiy(productID);
                  },
                  icon: Icon(Icons.add_circle_outline_rounded))
            ]),
          ),
        ),
      ),
    );
  }
}
