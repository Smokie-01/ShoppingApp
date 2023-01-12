import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const namedRoute = "user_products_screen";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    print(productsData.items.length);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.namedroute);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => Column(
                children: [
                  UserProductItem(
                    title: productsData.items[index].title,
                    imageURL: productsData.items[index].imageURL,
                    productID: productsData.items[index].id,
                  ),
                  Divider(),
                ],
              )),
    );
  }
}
