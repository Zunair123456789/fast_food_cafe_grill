// ignore_for_file: prefer_final_fields, file_names
import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Provider/Cart.dart' show Cart;
import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:fast_food_cafe_grill/Screens/EditMenuScreen.dart';
import 'package:fast_food_cafe_grill/Widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    const textStyle = TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Cart',
          style: textStyle,
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    backgroundColor: const Color(0xFF3F51B5),
                    label: Text(
                      'Rs. ${cart.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) {
                  // ignore: unnecessary_string_interpolations
                  return CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].title,
                    cart.items.values.toList()[i].price.toDouble(),
                    cart.items.values.toList()[i].quantity,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authId = Provider.of<Auth>(context, listen: false);
    return _isLoading
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : TextButton(
            onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
                ? null
                : () async {
                    final check =
                        Provider.of<Order>(context, listen: false).cafeName;
                    if (check == null || check == '') {
                      ErrorDialog('Cafe Not Select',
                          'Please first select any cafe from the home screen');
                    }
                    final phoneCheck =
                        Provider.of<Auth>(context, listen: false).phone;
                    final locatCheck =
                        Provider.of<Auth>(context, listen: false).locationPoint;
                    if (phoneCheck == null || locatCheck == null) {
                      Fluttertoast.showToast(
                          msg:
                              "Please add cell number or location in more Screen",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    //  else if (phoneCheck == null) {
                    //   ErrorDialog('Cell Phone & Location',
                    //       'Please add your cell phone number  to more Screen');
                    //   return;
                    // } else if (locatCheck == null) {
                    //   ErrorDialog('Location',
                    //       'Please add your Location  to more Screen');
                    //   return;
                    // }

                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Order>(context, listen: false).addOrder(
                        widget.cart.items.values.toList(),
                        widget.cart.totalAmount,
                        Provider.of<Auth>(context, listen: false).userId);
                    setState(() {
                      _isLoading = false;
                    });
                    widget.cart.clear();
                  },
            child: const Text(
              'ORDER NOW',
              style: TextStyle(
                color: Color(0xFF3F51B5),
              ),
            ),
          );
  }
}
