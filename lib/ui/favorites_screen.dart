import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/ui/detail_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset('assets/bg1.png'),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurant',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .apply(color: primaryColor),
                      ),
                      Text(
                        'Recomendation restaurant for you!',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(
                    child: Consumer<FavoriteProvider>(
                        builder: (context, provider, child) {
                      if (provider.state == ResultState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (provider.state == ResultState.HasData) {
                        List<Restaurant> _restaurant = provider.favorite;
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: provider.favorite.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(_restaurant[index].id),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text(
                                  "Remove Favorite",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .apply(color: Colors.white),
                                )),
                              ),
                              onDismissed: (direction) {
                                provider.removeFavorite(_restaurant[index].id);
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigation.intentWithData(
                                      DetailScreen.routeName,
                                      _restaurant[index].id);
                                },
                                child: Hero(
                                  tag: _restaurant[index].id,
                                  child: Container(
                                    height: 120,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://restaurant-api.dicoding.dev/images/medium/${_restaurant[index].pictureId}"),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black45, BlendMode.darken),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 4.0), //(x,y)
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _restaurant[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .apply(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_sharp,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(_restaurant[index].city,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .apply(
                                                            color:
                                                                Colors.white)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.grade_rounded,
                                                  color: Color(0xFFDEA921),
                                                  size: 14,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                    _restaurant[index]
                                                        .rating
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .apply(
                                                            color:
                                                                Colors.white))
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (provider.state == ResultState.NoData) {
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
                                provider.message,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text('');
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
