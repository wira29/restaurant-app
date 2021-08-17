import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantsResult {
  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  int founded;
  List<Restaurant> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"] != null ? json["message"] : "",
        count: json["count"] != null ? json["count"] : 0,
        founded: json["founded"] != null ? json["founded"] : 0,
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
