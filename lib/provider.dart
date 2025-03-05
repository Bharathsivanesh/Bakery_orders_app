import 'dart:ffi';

import 'package:flutter/material.dart';

class Tablenumberprovider extends ChangeNotifier {
  //------------------------------------------------
  String _tableNumber = '';
  String get tableNumber => _tableNumber;
  void settablenumber(String table) {
    //Table number
    _tableNumber = table;
    notifyListeners();
  }

//-----------------------------------------------
  double totalAmount = 0;

  void updateTotalAmount(double amount) {
    //total in admin page (current date)
    totalAmount += amount;
    notifyListeners();
  }

//-----------------------------------------------------------
  String _maxSoldItem = ' ';
  String get maxSoldItem => _maxSoldItem;
  //maximum sold
  void setMaxSoldItem(String value) {
    _maxSoldItem = value;
    notifyListeners();
  }

// ---------------------------------------------------------
  String _minSoldItem = ' ';
  String get minSoldItem => _minSoldItem;

  void setMinSoldItem(String value) {
    _minSoldItem = value; //minmum item sold
    notifyListeners();
  }

//--------------------------------------------------------
  double _ta = 0;
  double get ta => _ta; //store total amount in profit page

  void setta(double table) {
    _ta = table;
    notifyListeners();
  }

//-----------------------------------------------------------------
  List<Map<String, dynamic>> _orderedItems = [];
  List<Map<String, dynamic>> get orderedItems => _orderedItems;
  void addTocart(String name, String image, int rs) {
    _orderedItems.add({
      //Strore add to cart and display in cart page
      'name': name,
      'image': image,
      'price': rs,
    });
    notifyListeners();
  }

//--------------------------------------------------------
  String _total = '';
  String get total => _total;
  void settotal(String total) {
    //This is for total for final checkout and in qr code
    _total = total;
    notifyListeners();
  }
}
