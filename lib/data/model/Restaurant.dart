import 'dart:convert';

import 'package:restaurant_app/data/model/category.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'menu.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late bool isFavorite;
  late List<Menu> foods;
  late List<Menu> drinks;
  late List<Category> categories;
  late List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
    required this.categories,
    required this.customerReviews,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    foods = restaurant['menus'] != null
        ? List<Menu>.from(
            restaurant['menus']['foods'].map((x) => Menu.fromJson(x)))
        : [];
    drinks = restaurant['menus'] != null
        ? List<Menu>.from(
            restaurant['menus']['drinks'].map((x) => Menu.fromJson(x)))
        : [];
    categories = restaurant['categories'] != null
        ? List<Category>.from(
            restaurant["categories"].map((x) => Category.fromJson(x)))
        : [];
    customerReviews = restaurant['customerReviews'] != null
        ? List<CustomerReview>.from(restaurant["customerReviews"]
            .map((x) => CustomerReview.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> map = jsonDecode(json);
  final List parsed = map['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
