import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart_product.dart';
import 'package:shopapp/providers/orders_provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/004%20auth-screen.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/order_screen.dart';
import 'package:shopapp/screens/product_detailed_screen.dart';
import 'package:shopapp/screens/product_overview.dart';
import 'package:shopapp/screens/user_product_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
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
        home: AuthScreen(),
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
