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
    final scaffold = ScaffoldMessenger.of(context);
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
              icon: const Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .removeProduct(productID);
                  } catch (e) {
                    scaffold.showSnackBar(const SnackBar(
                        content: Text(
                      "Deleting failed",
                      textAlign: TextAlign.center,
                    )));
                  }
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
