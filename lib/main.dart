import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart_product.dart';
import 'package:shopapp/providers/orders_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/order_screen.dart';
import 'package:shopapp/screens/product_detailed_screen.dart';
import 'package:shopapp/screens/product_overview.dart';
import 'package:shopapp/screens/user_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: ((context) => Cart()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Orders()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailedScreen.routeNamed: (context) =>
              ProductDetailedScreen(),
          CartScreen.namedRoute: (context) => CartScreen(),
          OrderScreen.routeNamed: (context) => OrderScreen(),
          UserProductScreen.namedRoute: (context) => UserProductScreen(),
          EditProductScreen.namedroute: (context) => EditProductScreen()
        },
      ),
    );
  }
}
