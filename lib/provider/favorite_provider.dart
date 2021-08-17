import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state = ResultState.Loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();

    if (_favorite.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = "Empty Data";
    }

    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (err) {
      _state = ResultState.Error;
      _message = 'Error => $err';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteItem = await databaseHelper.getFavoriteById(id);
    if (favoriteItem.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (err) {
      _state = ResultState.Error;
      _message = 'Error => $err';
      notifyListeners();
    }
  }
}
