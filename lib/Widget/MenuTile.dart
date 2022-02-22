// ignore_for_file: prefer_final_fields, file_names, use_key_in_widget_constructors

import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Provider/Menu.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/ItemDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  // final Menu menu;
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
              height: 160,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      GridTile(
                          child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 110,
                        width: 160,
                      )),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                              onTap: () {
                                product.toggleFavoriteStatus();
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
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
