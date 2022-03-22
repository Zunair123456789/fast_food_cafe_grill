import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:fast_food_cafe_grill/Widget/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, index) =>
              OrderItems(ordersData.orders[index])),
    );
  }
}
