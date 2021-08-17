import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: textSecondary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextField(
                                        controller: _searchController,
                                        onSubmitted: (query) =>
                                            provider.search(query),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search...",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.refresh();
                                      setState(() {
                                        _searchController.text = "";
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.refresh_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: Consumer<RestaurantProvider>(
                                  builder: (context, state, _) {
                                    if (state.state == ResultState.Loading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (state.state ==
                                        ResultState.HasData) {
                                      List<Restaurant> restaurants =
                                          state.result.restaurants;
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        children: List.generate(
                                            restaurants.length,
                                            (index) =>
                                                itemGrid(restaurants[index])),
                                      );
                                    } else if (state.state ==
                                        ResultState.NoData) {
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (state.state ==
                                        ResultState.Error) {
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Text(
                                                state.runtime ==
                                                        'SocketException'
                                                    ? 'an error occurred with the network'
                                                    : state.message,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Center(child: Text(''));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }

  InkWell itemGrid(Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(DetailScreen.routeName, restaurant.id);
      },
      child: Hero(
        tag: restaurant.id,
        child: Container(
          height: 156,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(
                    "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.darken)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 4.0), //(x,y)
                blurRadius: 8.0,
              ),
            ],
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .apply(color: Colors.white)),
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
                      Text(restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .apply(color: Colors.white))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
