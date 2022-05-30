// ignore_for_file: file_names, empty_catches

import 'dart:async';

import 'dart:io';

import 'package:fast_food_cafe_grill/Provider/Menu.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  List _listOfCategories = [
    'Everyday Value',
    'Make it a Meal',
    'Signature Box',
    'Sharing',
    'Mid Night Deals',
    'Snacks',
    'Deals'
  ];
  final String authToken;
  final String userId;
  List tempList = [];
  File? pickedImage;

  MenusProvider(this.userId, this.authToken, this._listOfMeals);

  void addDataToTemop(String category) {
    if (tempList.contains(category)) {
      return;
    } else {
      tempList.add(category);
    }
  }

  void emptyTempList() {
    tempList.clear();
  }

  List<String> get listOfCategories {
    return [..._listOfCategories];
  }

  List<Menu> get listOfMeal {
    return [..._listOfMeals];
  }

  List<Menu> listByCategory(String category) {
    final hello = [
      ..._listOfMeals.where((element) => element.categories.contains(category))
    ];
    // print(hello);
    return hello;
  }

  Menu findById(String id) {
    return _listOfMeals.firstWhere((pro) => pro.id == id);
  }

  List<Menu> get favoriteItem {
    return _listOfMeals.where((prod) => prod.isFavorite).toList();
  }

  List<String> _historyOrder = [];

  void history() {}
  // List<Menu> get historyItem {
  //   List<Menu> list = [];
  //   for (var i = 0; i < _historyOrder.length; i++) {
  //     if (_historyOrder[i].) {

  //     }
  //   }
  //   return list;
  // }

  Future<void> fetchAndSetProduct() async {
    try {
      // var favoriteData;
      final List<Menu> loadedMenu = [];
      final snap = FirebaseFirestore.instance.collection('menuItem').get();
      final response = await snap;
      final extractedData = response.docs.map((e) => e);
      // final urlFavorite = FirebaseFirestore.instance.collection('users').get();
      // final snap1 = await urlFavorite;
      // final Data = snap1.docs.map((e) => e);
      // Data.forEach((data) {
      //   favoriteData = data;
      // });
      // final hel = await favoriteData;
      // bool check(String uid) {
      //   try {
      //     if (favoriteData == null) {
      //       return false;
      //     } else if (favoriteData[uid] == null) {
      //       return false;
      //     }
      //     return favoriteData[uid];
      //   } on HttpException catch (error) {
      //     if (error.toString().contains('does not exist')) {
      //       return false;
      //     }
      //   }
      //   return false;
      // }
      final userData = FirebaseFirestore.instance.collection('users').get();
      final response2 = await userData;
      final userIdData = response2.docs.map((e) => e);
      userIdData.forEach((userId) {
        _historyOrder.add(userId['history'].toString());
      });

      print(_historyOrder);
      extractedData.forEach((menuData) {
        loadedMenu.add(Menu(
            id: menuData.id,
            title: menuData['title'],
            imageUrl: menuData['imageUrl'],
            price: menuData['price'],
            description: menuData['description'],
            isFavorite: menuData['isFavorite'],
            // favoriteData == null
            //     ? false
            //     : favoriteData[menuData.id] ?? false,
            categories: menuData['categories']));
      });

      _listOfMeals = loadedMenu;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addMenu(Menu menu) async {
    String imageUrl = menu.imageUrl;
    try {
      if (pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('MenuItem')
            .child(menu.title + '.jpg');
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));
        imageUrl = await ref.getDownloadURL();
      }

      final firebase = FirebaseFirestore.instance.collection('menuItem');
      final response = await firebase.add({
        'title': menu.title,
        'imageUrl': imageUrl,
        'price': menu.price,
        'description': menu.description,
        'categories': tempList,
      });
      final newMenuItem = Menu(
          id: response.id,
          title: menu.title,
          imageUrl: imageUrl,
          price: menu.price,
          categories: tempList,
          description: menu.description);
      _listOfMeals.add(newMenuItem);
      tempList = [];
      pickedImage = null;
      notifyListeners();
    } catch (error) {
      throw error;
    }

    // throw error;
  }

  Future<void> updateMenu(String menuId, Menu newMenu) async {
    String imageUrl = newMenu.imageUrl;
    try {
      if (pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('MenuItem')
            .child(newMenu.title + '.jpg');
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));
        imageUrl = await ref.getDownloadURL();
      }
      final menuIndex =
          _listOfMeals.indexWhere((element) => element.id == menuId);
      if (menuIndex >= 0) {
        final firebase =
            FirebaseFirestore.instance.collection('menuItem').doc(menuId);
        await firebase.update({
          'title': newMenu.title,
          'imageUrl': imageUrl,
          'price': newMenu.price,
          'description': newMenu.description,
          'categories': tempList
        });

        _listOfMeals[menuIndex] = newMenu;

        notifyListeners();
      } else {
        // ignore: avoid_print
        print('...');
      }
    } catch (error) {
      rethrow;
    }
  }

  void deleteMenuItem(String menuId, String title) {
    final ref =
        FirebaseStorage.instance.ref().child('MenuItem').child(title + '.jpg');
    final firebase =
        FirebaseFirestore.instance.collection('menuItem').doc(menuId);
    final existingProductIndex =
        _listOfMeals.indexWhere((element) => element.id == menuId);
    var existingProduct = _listOfMeals[existingProductIndex];

    firebase.delete().then((response) async {
      _listOfMeals.removeAt(existingProductIndex);
      await ref.delete();
      // notifyListeners();
      existingProduct.dispose();
    }).catchError((_) {
      _listOfMeals.insert(existingProductIndex, existingProduct);
      // notifyListeners();
    });
    _listOfMeals.removeAt(existingProductIndex);
    notifyListeners();
  }
}
