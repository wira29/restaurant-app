import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/Restaurant.dart';
import 'package:restaurant_app/ui/DetailScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              bottom: 0,
              left: 0,
              child: Image.asset('assets/bg2.png'),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                          height: 40,
                        ),
                        Expanded(
                          child: FutureBuilder<String>(
                            future: DefaultAssetBundle.of(context)
                                .loadString('assets/restaurant.json'),
                            builder: (context, snapshot) {
                              final List<Restaurant> restaurants =
                                  parseRestaurant(snapshot.data);

                              return GridView.count(
                                crossAxisCount: 2,
                                children: List.generate(restaurants.length,
                                    (index) => itemGrid(restaurants[index])),
                              );
                            },
                          ),
                        )
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
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
      child: Hero(
        tag: restaurant.id,
        child: Container(
          height: 156,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(restaurant.pictureId),
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
