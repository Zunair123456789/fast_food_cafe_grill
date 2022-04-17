// ignore_for_file: file_names

import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Provider/Menu.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports

class ItemDetailScreen extends StatefulWidget {
  static String routeName = '/product-detail';

  const ItemDetailScreen({Key? key}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final listItem =
        Provider.of<MenusProvider>(context, listen: false).findById(itemId);
    // final quantity = Provider.of<Cart>(context).itemQuantity(itemId);
    // final product = Provider.of<Menu>(context, listen: false);
    const textStyle = TextStyle(
        fontFamily: 'Quicksand', fontWeight: FontWeight.w500, fontSize: 30);
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,c
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Consumer<Cart>(
              builder: (_, cart, chil) {
                return Badge(
                  child: chil ?? Container(),
                  value: cart.itemCount.toString(),
                );
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: listItem,
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  // color: Colors.amber,
                  margin: const EdgeInsets.only(
                      top: 90, left: 30, right: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listItem.title,
                        style: textStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Provider.of<Cart>(context, listen: false)
                                        .removeSingleItem(itemId);
                                  },
                                  icon: const Icon(Icons.remove)),
                              Consumer<Cart>(
                                builder: (ctx, cart, child) => Text(
                                  '${cart.itemQuantity(itemId)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Provider.of<Cart>(context, listen: false)
                                        .addItem(listItem.id, listItem.price,
                                            listItem.title);
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              listItem.toggleFavoriteStatus();
                            },
                            child: Consumer<Menu>(
                              builder: (ctx, product, _) => Icon(
                                product.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: const Color(0xFF3F51B5),
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Rs. ${listItem.price}',
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        listItem.description,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              // color: Theme.of(context).primaryColor,
                            ),
                            child: IconButton(
                                iconSize: 26,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Theme.of(context).primaryColor,
                                icon: const Icon(Icons.arrow_back)),
                          ),
                          // MaterialButton(
                          //     splashColor: const Color.fromARGB(255, 57, 47, 201),
                          //     color: Theme.of(context).primaryColor,
                          //     onPressed: () {
                          //       Navigator.of(context).pop();
                          //       Navigator.of(context).push(MaterialPageRoute(
                          //           builder: (context) => CartScreen()));
                          //     },
                          //     child: const Text(
                          //       'Order Now',
                          //       style: TextStyle(
                          //         color: Color.fromARGB(255, 221, 220, 220),
                          //       ),
                          //     ))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                // height: 130,
                // width: 130,
                top: MediaQuery.of(context).size.width * 0.12,
                left: MediaQuery.of(context).size.width * 0.28,
                // right: MediaQuery.of(context).size.width * 0.5,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color.fromARGB(255, 47, 47, 48),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipOval(
                        child: Image.network(
                      listItem.imageUrl,
                      width: 170,
                      height: 170,
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(45),
              //   color: Colors.amber,
              //   child:
              // ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width,
              //   child: Image.network(
              //     listItem.imageUrl,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              // Positioned(
              //     top: 10,
              //     left: 10,
              //     child: InkWell(
              //       child: const Icon(
              //         Icons.arrow_back,
              //         color: Colors.black,
              //         size: 30,
              //       ),
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
