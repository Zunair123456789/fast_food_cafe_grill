import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeItem extends ChangeNotifier {
  final String cafeId;
  final String cafeName;
  final String cafeDiscription;
  final String cafeImageUrl;
  CafeItem({
    required this.cafeId,
    required this.cafeName,
    required this.cafeDiscription,
    required this.cafeImageUrl,
  });
}

class Cafe extends ChangeNotifier {
  List<CafeItem> _listOfCafes = [];

  String _isSelected = '';

  String get isSelected {
    return _isSelected;
  }

  CafeItem findById() {
    return _listOfCafes.firstWhere((pro) => pro.cafeId == isSelected);
  }

  List<CafeItem> get listOfCafes {
    return [..._listOfCafes];
  }

  void cafeSelection(String cafeId) {
    _isSelected = cafeId;
    notifyListeners();
  }

  Future<void> fetchListOfCafes() async {
    try {
      final List<CafeItem> loadedCafes = [];
      final snap =
          FirebaseFirestore.instance.collection('listOfRestorant').get();
      final response = await snap;
      final extractedData = response.docs.map((e) => e);
      extractedData.forEach((cafeData) {
        loadedCafes.add(CafeItem(
          cafeId: cafeData.id,
          cafeName: cafeData['name'],
          cafeDiscription: cafeData['description'],
          cafeImageUrl: cafeData['imageUrl'],
        ));
        _listOfCafes = loadedCafes;
        notifyListeners();
        print('done cafe list');
      });
    } catch (e) {
      rethrow;
    }
  }

  void printlist(String a) {
    print(a);
    print(_listOfCafes[1].cafeName);
    // return;
  }
}
