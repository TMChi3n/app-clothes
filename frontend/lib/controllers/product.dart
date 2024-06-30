import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier{
  int _activepage =0;
  int get active => _activepage;
  set activePage(int newIndex){
    _activepage = newIndex;
    notifyListeners();
  }
}