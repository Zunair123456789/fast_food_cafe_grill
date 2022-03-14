// ignore_for_file: file_names
import 'dart:convert';

import 'package:fast_food_cafe_grill/Provider/Menu.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class MenusProvider extends ChangeNotifier {
  List<Menu> _listOfMeals = [
    // Menu(
    //   id: 'm1',
    //   title: 'Spaghetti with Tomato Sauce',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    //   price: 20,
    //   description: 'Meal is Good,Meal is Good',
    //   catogries: [],
    // ),
    // Menu(
    //   id: 'm2',
    //   title: 'Toast Hawaii',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    //   price: 10,
    //   description: 'Something is very good,Meal is Good',
    //   catogries: [],
    // ),
    // Menu(
    //     id: 'm3',
    //     title: 'Classic Hamburger',
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    //     price: 45,
    //     description: 'Something is favrite,Meal is Good',
    //     catogries: ['Make']),
    // Menu(
    //   id: 'm4',
    //   title: 'Spaghetti with Tomato Sauce',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    //   price: 20,
    //   description: 'Meal is Good,Meal is Good',
    //   catogries: [],
    // ),
    // Menu(
    //   id: 'm5',
    //   title: 'Toast Hawaii',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    //   price: 10,
    //   description: 'Something is very good,Meal is Good',
    //   catogries: [],
    // ),
    // Menu(
    //   id: 'm6',
    //   title: 'Classic Hamburger',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    //   price: 45,
    //   description: 'Something is favrite,Meal is Good',
    //   catogries: [],
    // ),
  ];

  // ignore: prefer_final_fields
  List _listOfCatogries = [
    'Everyday Value',
    'Make it a Meal',
    'Signature Box',
    'Sharing',
    'Mid Night Deals',
    'Snacks'
  ];

  List<Menu> get listOfMeal {
    return [..._listOfMeals];
  }

  Menu findById(String id) {
    // print(id);
    return _listOfMeals.firstWhere((pro) => pro.id == id);
  }

  List<Menu> get favoriteItem {
    return _listOfMeals.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetProduct() async {
    try {
      final List<Menu> loadedMenu = [];
      final snap = FirebaseFirestore.instance.collection('menuItem').get();
      final response = await snap;
      final extractedData = response.docs.map((e) => e);

      extractedData.forEach((menuData) {
        loadedMenu.add(Menu(
          id: menuData.id,
          title: menuData['title'],
          imageUrl: menuData['imageUrl'],
          price: menuData['price'],
          description: menuData['description'],
          isFavorite: menuData['isFavorite'],
          catogries: [],
        ));
      });
      // print(loadedMenu.first.id);
      _listOfMeals = loadedMenu;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addMenu(Menu menu) async {
    final hel = FirebaseFirestore.instance.collection('menuItem');
    try {
      final response = await hel.add({
        'title': menu.title,
        'imageUrl': menu.imageUrl,
        'price': menu.price,
        'description': menu.description,
        'isFavorite': menu.isFavorite
      });
      final newMenuItem = Menu(
          id: response.id,
          title: menu.title,
          imageUrl: menu.imageUrl,
          price: menu.price,
          catogries: menu.catogries,
          description: menu.description);
      _listOfMeals.add(newMenuItem);

      notifyListeners();
    } catch (error) {
      throw error;
    }

    // throw error;
  }

  Future<void> updateMenu(String menuId, Menu newMenu) async {
    final menuIndex =
        _listOfMeals.indexWhere((element) => element.id == menuId);
    if (menuIndex >= 0) {
      final hel = FirebaseFirestore.instance.collection('menuItem').doc(menuId);
      await hel.update({
        'title': newMenu.title,
        'imageUrl': newMenu.imageUrl,
        'price': newMenu.price,
        'description': newMenu.description,
      });

      _listOfMeals[menuIndex] = newMenu;

      notifyListeners();
    } else {
      // ignore: avoid_print
      print('...');
    }
  }

  void deleteMenuItem(String menuId) {
    final hel = FirebaseFirestore.instance.collection('menuItem').doc(menuId);
    final existingProductIndex =
        _listOfMeals.indexWhere((element) => element.id == menuId);
    var existingProduct = _listOfMeals[existingProductIndex];

    hel.delete().then((response) {
      _listOfMeals.removeAt(existingProductIndex);
      notifyListeners();
      existingProduct.dispose();
    }).catchError((_) {
      _listOfMeals.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
    _listOfMeals.removeAt(existingProductIndex);
    notifyListeners();
  }
}
