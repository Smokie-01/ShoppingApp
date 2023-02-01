import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopapp/providers/orders_provider.dart' as ord;
import 'package:intl/intl.dart';

class OrderProducts extends StatefulWidget {
  final ord.OrderItem order;
  OrderProducts(this.order);

  @override
  State<OrderProducts> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProducts> {
  bool isloading = false;

  @override
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("'\$${widget.order.totalAmount}'"),
            subtitle: Text(
                DateFormat("dd-mm-yyyy  hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: min(widget.order.products.length * 20 + 100, 180),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: ((context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.order.products[index].title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.order.products[index].quantity}x   \$${widget.order.products[index].price}",
                          style: TextStyle(color: Colors.grey.shade300),
                        )
                      ],
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
