import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/AddingNewMeal.dart';
import 'package:fast_food_cafe_grill/Widget/UserMenuEdit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuData = Provider.of<MenusProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Menus'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddingNewMeal()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: menuData.listOfMeal.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserMenuEdit(menuData.listOfMeal[i].title,
                  menuData.listOfMeal[i].imageUrl),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}