import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';

import 'package:shopapp/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageURL;
  final String productID;
  UserProductItem(
      {required this.title, required this.imageURL, required this.productID});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.namedroute,
                    arguments: productID);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure ?"),
                          content: Text("you want to delete this item!"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("no")),
                            TextButton(
                                onPressed: () {
                                  Provider.of<Products>(context, listen: false)
                                      .removeProduct(productID);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes I do !"))
                          ],
                        );
                      });
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
