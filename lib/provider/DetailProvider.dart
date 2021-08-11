import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/CustomerReview.dart';
import 'package:restaurant_app/data/model/DetailResult.dart';
import 'package:restaurant_app/data/services/ApiService.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailProvider({required this.apiService, required this.id}) {
    _fetchDetail(id);
  }

  late DetailResult _result;
  String _message = "";
  late ResultState _state;
  late List<CustomerReview> _review;
  String _runtimeType = '';

  String get message => _message;
  DetailResult get result => _result;
  ResultState get state => _state;
  List<CustomerReview> get review => _review;
  String get runtime => _runtimeType;

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.error) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = "Error --> ${restaurant.message}";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        _review = restaurant.restaurant.customerReviews;
        return _result = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      _runtimeType = e.runtimeType.toString();
      notifyListeners();
      return _message = "Error --> $e";
    }
  }

  void addReview(String data) {
    _postReview(data);
  }

  Future<dynamic> _postReview(String data) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final reviewResult = await apiService.postReview(data);
      if (reviewResult.error) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = "Error --> ${reviewResult.message}";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _review = reviewResult.customerReviews;
      }
    } catch (e) {
      _state = ResultState.Error;
      _runtimeType = e.runtimeType.toString();
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
