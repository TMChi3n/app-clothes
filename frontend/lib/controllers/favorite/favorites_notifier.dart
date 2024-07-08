import 'package:flutter/material.dart';

class FavoritesChangeNotifier extends ChangeNotifier {
  List<dynamic> _listId = [];
  List<dynamic> _favorites = [];

  List<dynamic> get listId => _listId;

  set listId(List<dynamic> newlistId){
    _listId = newlistId;
    notifyListeners();
  }

  List<dynamic> get listFavorites => _favorites;
  set listFavorite(List<dynamic> newlistFavorite){
    _favorites = newlistFavorite;
    notifyListeners();
  }
}