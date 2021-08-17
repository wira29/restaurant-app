import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/data/services/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

void main() {
  group('Testing Restaurant Provider', () {
    late RestaurantProvider restaurantProvider;

    var testRestaurant = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    setUp(() async {
      restaurantProvider = RestaurantProvider(apiService: ApiService());
      await restaurantProvider.fetchAllRestaurant();
    });

    test('Cek nilai kembalian dari restaurant provider', () {
      RestaurantsResult restaurantsResult = restaurantProvider.result;
      var result = restaurantsResult.restaurants[0].name ==
          Restaurant.fromJson(testRestaurant).name;
      expect(result, true);
    });
  });
}
