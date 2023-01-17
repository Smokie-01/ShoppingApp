import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_screen.dart';
import 'package:shopapp/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text("Hello User !"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
            Divider(
              color: Colors.white60,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Your Orders"),
              onTap: () {
                Navigator.pushNamed(context, OrderScreen.routeNamed);
              },
            ),
            Divider(
              color: Colors.white60,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Products"),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, UserProductScreen.namedRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
