// ignore_for_file: file_names

import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/MenuTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports

class MenuWithType extends StatelessWidget {
  final String menuName;
  const MenuWithType(this.menuName, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontFamily: 'Quicksand', fontWeight: FontWeight.bold, fontSize: 20);
    var listItem = Provider.of<MenusProvider>(context).listByCategory(menuName);
    // var listItem2 = context.read<MenusProvider>().listOfMeal;
    return Column(
      children: [
        ListTile(
          title: Text(
            menuName,
            style: textStyle,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              ...List.generate(
                listItem.length,
                (i) => ChangeNotifierProvider.value(
                  value: listItem[i],
                  child: MenuTile(menuName),
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
