import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const namedRoute = "user_products_screen";
  Future<void> _refreshedData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
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
      body: RefreshIndicator(
        onRefresh: () => _refreshedData(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      UserProductItem(
                        title: productsData.items[index].title,
                        imageURL: productsData.items[index].imageURL,
                        productID: productsData.items[index].id,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
