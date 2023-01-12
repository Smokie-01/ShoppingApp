import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  bool favoriteItems;
  ProductsGrid(this.favoriteItems);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); // This will provide us Products context;

    final products = favoriteItems
        ? productsData.favoriteItems
        : productsData.items; // This line has actual list of Products(items);

    return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //==> how many cloumns;
          childAspectRatio: 3 / 2, //--> is a ratio of height and width;
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ), //gridDelegate means , How should the grid Structure => how many columns or how many rows;
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(),
            ));
  }
}
