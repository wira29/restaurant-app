import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/services/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/review_dialog.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/detailScreen";

  final String id;

  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String menuActive = "foods";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(apiService: ApiService(), id: widget.id),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Consumer<DetailProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    final _restaurant = state.result.restaurant;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: _restaurant.id,
                            child: Container(
                              height: 256,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://restaurant-api.dicoding.dev/images/large/${_restaurant.pictureId}"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black38, BlendMode.darken),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _restaurant.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .apply(color: primaryColor),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          size: 14,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          _restaurant.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .apply(color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Consumer<FavoriteProvider>(
                                  builder: (context, provider, child) {
                                    return FutureBuilder<bool>(
                                        future:
                                            provider.isFavorite(_restaurant.id),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("");
                                          } else {
                                            var favorite = snapshot.data!;
                                            return IconButton(
                                              onPressed: () {
                                                if (favorite) {
                                                  provider.removeFavorite(
                                                      _restaurant.id);
                                                } else {
                                                  provider
                                                      .addFavorite(_restaurant);
                                                }
                                              },
                                              icon: Icon(
                                                favorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: favorite
                                                    ? primaryColor
                                                    : Colors.grey[600],
                                                size: 30,
                                              ),
                                            );
                                          }
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _restaurant.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .apply(color: Colors.grey[600]),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Menu",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      menuActive = "foods";
                                    });
                                  },
                                  child: Text(
                                    "Foods",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(
                                            color: menuActive == "foods"
                                                ? primaryColor
                                                : Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      menuActive = "drinks";
                                    });
                                  },
                                  child: Text(
                                    "Drinks",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(
                                            color: menuActive == "foods"
                                                ? Colors.grey[600]
                                                : primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 250,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: menuActive == "foods"
                                    ? _restaurant.foods.length
                                    : _restaurant.drinks.length,
                                itemBuilder: (context, index) {
                                  return itemMenu(_restaurant, index);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reviews",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ReviewDialog(widget.id, state);
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        Text(
                                          "Add Review",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 250,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.review.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return itemReview(
                                      context, index, state.review);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.data_saver_off,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.Error) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            state.runtime == 'SocketException'
                                ? 'an error occurred with the network'
                                : state.message,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigation.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container itemReview(
      BuildContext context, int index, List<CustomerReview> customerReviews) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/avatar.png',
            width: 32,
            height: 32,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerReviews[index].name,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(customerReviews[index].date,
                    style: Theme.of(context).textTheme.caption),
                SizedBox(
                  height: 8,
                ),
                Text(
                  customerReviews[index].review,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container itemMenu(Restaurant _restaurant, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            menuActive == "foods" ? Icons.food_bank : Icons.local_drink,
            color: primaryColor,
          ),
          SizedBox(
            width: 16,
          ),
          Text(menuActive == "foods"
              ? _restaurant.foods[index].name
              : _restaurant.drinks[index].name),
        ],
      ),
    );
  }
}
