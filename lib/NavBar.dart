// ignore_for_file: prefer_final_fields, file_names

import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Screens/FavoriteScreen.dart';
import 'package:fast_food_cafe_grill/Screens/MoreScreen.dart';
import 'package:flutter/material.dart';

import 'package:fast_food_cafe_grill/Screens/CartScreen.dart';
import 'package:fast_food_cafe_grill/Screens/MenuScreen.dart';
import 'package:fast_food_cafe_grill/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'Widget/badge.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int indexVal = 0;

  final navIcon = const <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.restaurant_outlined, size: 30),
    Icon(Icons.shopping_cart_outlined, size: 30),
    Icon(Icons.favorite_outline, size: 30),
    Icon(Icons.more_vert, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: CurvedActionBar(
          onTab: (value) {
            /// perform action here
            // print(value);
          },
          activeIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              Icons.shopping_cart,
              size: 50,
              color: Color(0xFF3F51B5),
            ),
          ),
          inActiveIcon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
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
                color: Colors.black26,
              ),
            ),
          ),
          text: "Cart"),
      activeColor: Theme.of(context).primaryColor,
      navBarBackgroundColor: Colors.white,
      inActiveColor: Colors.black45,
      appBarItems: [
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.home,
              color: Color(0xFF3F51B5),
            ),
            inActiveIcon: const Icon(
              Icons.home_outlined,
              color: Colors.black26,
            ),
            text: 'Home'),
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.restaurant,
              color: Color(0xFF3F51B5),
            ),
            inActiveIcon: const Icon(
              Icons.restaurant_outlined,
              color: Colors.black26,
            ),
            text: 'Menu'),
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.favorite,
              color: Color(0xFF3F51B5),
            ),
            inActiveIcon: const Icon(
              Icons.favorite_outline,
              color: Colors.black26,
            ),
            text: 'Favorite'),
        FABBottomAppBarItem(
            activeIcon: const Icon(
              Icons.more_vert,
              color: Color(0xFF3F51B5),
            ),
            inActiveIcon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black26,
            ),
            text: 'More'),
      ],
      bodyItems: const [
        HomeScreen(),
        MenuScreen(),
        FavoiteScreen(),
        MoreScreen(),
      ],
      actionBarView: const CartScreen(),
    );

    //  Scaffold(
    // bottomNavigationBar: CurvedNavigationBar(
    //   backgroundColor: const Color(0xFF3F51B5),
    //   items: navIcon,
    //   onTap: (index) {
    //     setState(() {});
    //     indexVal = index;
    //   },
    // ),
    // body: _listpages[indexVal],

    // );
  }
}
