import 'package:flutter/material.dart';

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
            IconButton(onPressed: () {}, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
