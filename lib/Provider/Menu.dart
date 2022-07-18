// ignore_for_file: prefer_final_fields, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Menu extends ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final List categories;
  bool isFavorite;
  Menu({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.categories,
    this.isFavorite = false,
  });
  Future<void> toggleFavoriteStatus(String userId) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final hel = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      List<String> list = [id];

      await hel.update({'isFavorite': FieldValue.arrayUnion(list)});

      if (!isFavorite) {
        await hel.update({'isFavorite': FieldValue.arrayRemove(list)});
      }
      // await hel.update({id: isFavorite});
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
