import 'package:restaurant_app/data/model/Restaurant.dart';

class DetailResult {
  DetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}
