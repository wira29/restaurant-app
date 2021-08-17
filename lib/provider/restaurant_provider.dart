import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/services/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late RestaurantsResult _result;
  String _message = '';
  String _runtimeType = '';
  late ResultState _state;

  String get message => _message;
  String get runtime => _runtimeType;
  RestaurantsResult get result => _result;
  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      _runtimeType = e.runtimeType.toString();
      notifyListeners();
      return _message = "Error --> $e";
    }
  }

  void search(String query) {
    _searchRestaurant(query);
  }

  void refresh() {
    fetchAllRestaurant();
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      _runtimeType = e.runtimeType.toString();
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
