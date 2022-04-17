// ignore_for_file: file_names

import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/EditMenuScreen.dart';
import 'package:fast_food_cafe_grill/Widget/UserMenuEdit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class MenuUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _refreshMenu() async {
      await Provider.of<MenusProvider>(context, listen: false)
          .fetchAndSetProduct();
    }

    final menuData = Provider.of<MenusProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Your Menus'),
        actions: [
          IconButton(
              onPressed: () {
                menuData.emptyTempList();
                Navigator.of(context)
                    .pushNamed(EditMenuScreen.routeName, arguments: '');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMenu,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: menuData.listOfMeal.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserMenuEdit(
                    menuData.listOfMeal[i].id,
                    menuData.listOfMeal[i].title,
                    menuData.listOfMeal[i].imageUrl),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
