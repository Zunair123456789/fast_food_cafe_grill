import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/MenuTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoiteScreen extends StatelessWidget {
  const FavoiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listItem = Provider.of<MenusProvider>(context).favoriteItem;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: listItem.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: listItem[i],
          child: MenuTile(),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
      ),
    );
  }
}
