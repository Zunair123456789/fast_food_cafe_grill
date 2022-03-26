import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:fast_food_cafe_grill/Widget/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Your Orders'),
        ),
        body: FutureBuilder(
            future:
                Provider.of<Order>(context, listen: false).fetchAndSetOrder(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.error != null) {
                return const Center(
                  child: Text('An error has occored'),
                );
              } else {
                return Consumer<Order>(
                  builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (context, index) =>
                          OrderItems(orderData.orders[index])),
                );
              }
            }));
  }
}
