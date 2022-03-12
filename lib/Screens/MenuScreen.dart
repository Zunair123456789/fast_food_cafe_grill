// ignore_for_file: prefer_final_fields, file_names
import 'package:fast_food_cafe_grill/Widget/MenuWithType.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            NavigationToolbar.kMiddleSpacing -
            MediaQuery.of(context).padding.top,
        child: SingleChildScrollView(
          // ignore: sized_box_for_whitespace
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 30,
              ),
              //.......................................................................................//////.....
              const MenuWithType('Everyday Value'),
              const MenuWithType('Make it a Meal'),
              const MenuWithType('Signature Box'),
              const MenuWithType('Sharing'),
              const MenuWithType('Mid Night Deals'),
              const MenuWithType('Snacks'),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
