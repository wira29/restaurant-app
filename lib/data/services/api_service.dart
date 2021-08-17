import 'dart:convert';

import 'package:restaurant_app/data/model/detail_result.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/review_result.dart';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _apiKey = "12345";
  static final String _contentType = "application/json";

  Future<RestaurantsResult> listRestaurant() async {
    Uri uri = Uri.parse("${_baseUrl}list");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<DetailResult> detailRestaurant(String id) async {
    Uri uri = Uri.parse("${_baseUrl}detail/${id}");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantsResult> searchRestaurant(String query) async {
    Uri uri = Uri.parse("${_baseUrl}search?q=${query}");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<ReviewResult> postReview(String data) async {
    Uri uri = Uri.parse("${_baseUrl}review");
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': _contentType,
        'X-Auth-Token': _apiKey,
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return ReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
