import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders_provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';

import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeNamed = "order_screen";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderProduct(orderData.orders[index]),
      ),
    );
  }
}
