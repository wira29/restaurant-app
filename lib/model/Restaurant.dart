import 'dart:convert';

import 'Menu.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late List<Menu> foods;
  late List<Menu> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    foods = parseMenu(restaurant['menus']['foods']);
    drinks = parseMenu(restaurant['menus']['drinks']);
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> map = jsonDecode(json);
  final List parsed = map['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
