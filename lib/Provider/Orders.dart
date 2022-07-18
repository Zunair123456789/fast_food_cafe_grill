import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userData {
  final String userName;
  final String phoneNumber;
  final GeoPoint loction;
  userData({
    required this.userName,
    required this.phoneNumber,
    required this.loction,
  });
}

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final userData user;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime,
      required this.user});
}

class Order extends ChangeNotifier {
  List<OrderItem> _orders = [];
  String? cafeName;

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final List<OrderItem> loadedOrder = [];
    final snap = FirebaseFirestore.instance
        .collection('Orders-$cafeName')
        .orderBy('date', descending: true)
        .get();
    final response = await snap;
    final extractedData = response.docs.map((e) => e);
    if (extractedData.isEmpty) {
      return;
    }
    // ignore: avoid_function_literals_in_foreach_calls

    extractedData.forEach((orderData) async {
      final data = await findUserByUserid(orderData['user']);

      loadedOrder.add(
        OrderItem(
            id: orderData.id,
            amount: await orderData['amount'],
            dateTime: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ),
                )
                .toList(),
            user: data),
      );
      _orders = loadedOrder.reversed.toList();

      notifyListeners();
    });
  }

  Future<userData> findUserByUserid(String userids) async {
    final value =
        await FirebaseFirestore.instance.collection('users').doc(userids).get();
    final som = userData(
        userName: await value.data()!['fname'],
        phoneNumber: await value.data()!['phone'],
        loction: await value.data()!['location']);

    return som;
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, String? userId) async {
    final firebase = FirebaseFirestore.instance.collection('Orders-$cafeName');
    final timestamp = DateTime.now();
    final respose = await firebase.add({
      'amount': total,
      'date': timestamp.toIso8601String(),
      'products': cartProducts
          .map((cp) => {
                'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price,
              })
          .toList(),
      'user': userId
    });

    // _orders.insert(
    //     0,
    //     OrderItem(
    //         id: respose.id,
    //         amount: total,
    //         products: cartProducts,
    //         dateTime: DateTime.now(),
    //         user: userId));
    notifyListeners();
  }
}
