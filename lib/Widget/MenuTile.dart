// ignore_for_file: prefer_final_fields, file_names, use_key_in_widget_constructors

import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Provider/Menu.dart';
import 'package:fast_food_cafe_grill/Screens/ItemDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  // final String menu;
  // MenuTile(this.menu);
  // ignore: use_key_in_widget_constructors
  // MenuTile(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Menu>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final cafeData = Provider.of<Cafe>(context, listen: false).findById();
    return Container(
      margin: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ItemDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GridTile(
                          child: Container(
                        height: 120,
                        width: 200,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          height: 120,
                          width: 200,
                        ),
                      )),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                              onTap: () {
                                product.toggleFavoriteStatus(cafeData.cafeName);
                              },
                              child: Consumer<Menu>(
                                builder: (ctx, product, _) => Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: const Color(0xFF3F51B5)),
                              ))),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () {
                            cart.addItem(
                              product.id,
                              product.price,
                              product.title,
                            );
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Added item to Cart!',
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    cart.removeSingleItem(product.id);
                                  },
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Color(0xFF3F51B5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Rs. ${product.price}',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
