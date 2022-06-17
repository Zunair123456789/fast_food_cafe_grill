import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:flutter/cupertino.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order extends ChangeNotifier {
  List<OrderItem> _orders = [];
  String? cafeName;

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final List<OrderItem> loadedOrder = [];
    final snap =
        FirebaseFirestore.instance.collection('Orders-$cafeName').get();
    final response = await snap;
    final extractedData = response.docs.map((e) => e);
    if (extractedData.isEmpty) {
      return;
    }
    // ignore: avoid_function_literals_in_foreach_calls
    extractedData.forEach((orderData) {
      loadedOrder.add(
        OrderItem(
          id: orderData.id,
          amount: orderData['amount'],
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
        ),
      );
      _orders = loadedOrder.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
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
                'price': cp.price
              })
          .toList()
    });

    _orders.insert(
        0,
        OrderItem(
          id: respose.id,
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
