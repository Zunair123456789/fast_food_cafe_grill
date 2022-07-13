// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fast_food_cafe_grill/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String? _fname;

  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  String? _phone;
  LatLng? _location;
  List<Placemark>? placemarks;

  bool get isAuth {
    if (token != null) {
      return true;
    }
    return false;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get fname {
    return _fname;
  }

  LatLng? get locationPoint {
    return _location;
  }

  String? get phone {
    return _phone;
  }

  void setname(String name) {
    _fname = name;
  }

  void setPhone(String num) {
    _phone = num;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDDbiVc9hc_HqimQcNztAzoFvvquw21axc';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      if (urlSegment == 'signUp') {
        final db = FirebaseFirestore.instance.collection('users').doc(userId);
        await db.set({'email': email, 'fname': _fname});
      }

      if (urlSegment == 'signInWithPassword') {
        GeoPoint? some;
        final snap = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots();
        // snap.firstWhere((element) => _fname = element['fname']);

        snap.forEach((element) {
          _fname = element['fname'];
          some = element['location'] != null
              ? element['location'] as GeoPoint
              : null;
          _phone = element['phone'] ?? Null;
        }).then((value) async {
          print('Print done');
          _location =
              some == null ? null : LatLng(some!.latitude, some!.longitude);
          await address();
        });
        print(_location);
        print(some);
        await snap.first;
      }
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
        'fname': _fname,
        'phone': _phone,
        'location': _location
      });

      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> phoneToFirestore() async {
    final db = FirebaseFirestore.instance.collection('users').doc(userId);
    await db.update({'phone': _phone});
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
      'fname': _fname,
      'phone': _phone,
      'location': _location
    });

    prefs.setString('userData', userData);
  }

  Future<void> address() async {
    if (_location != null) {
      placemarks = await placemarkFromCoordinates(
          _location!.latitude, _location!.longitude);
      final p = placemarks![0];
      final address = '${p.name},${p.locality},${p.country},${p.street}';
      print(address);
    }
    notifyListeners();
  }

  Future<void> locationToFireStore(LatLng pos) async {
    final db = FirebaseFirestore.instance.collection('users').doc(userId);
    _location = pos;
    await db.update({'location': GeoPoint(pos.latitude, pos.longitude)});
    address();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
      'fname': _fname,
      'phone': _phone,
      'location': _location
    });

    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final str = prefs.getString('userData');

    final extractedUserDate = json.decode(str!);

    final expiryDate =
        DateTime.parse(extractedUserDate['expiryDate'].toString());

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserDate['token'].toString();
    _userId = extractedUserDate['userId'].toString();
    _fname = extractedUserDate['fname'].toString();
    _phone = extractedUserDate['phone'].toString();
    _location = extractedUserDate['locaton'];
    _expiryDate = expiryDate;

    await address();
    notifyListeners();

    // Timer(Duration(seconds: 15), () {});
    return true;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    _fname = null;
    _location = null;
    _phone = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    notifyListeners();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
