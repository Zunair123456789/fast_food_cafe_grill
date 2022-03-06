// ignore_for_file: prefer_final_fields, file_names
import 'package:flutter/material.dart';

class Menu extends ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavorite;
  Menu({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
