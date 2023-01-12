import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';

class ProductDetailedScreen extends StatelessWidget {
  static const routeNamed = "Product_detailed_Screem";
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)
        ?.settings
        .arguments; // is the ID of Tapped Product;s
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productID.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageURL,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "\$${loadedProduct.price}",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
