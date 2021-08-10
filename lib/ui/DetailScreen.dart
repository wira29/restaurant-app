import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/Menu.dart';
import 'package:restaurant_app/model/Restaurant.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/detailScreen";

  final Restaurant restaurant;

  DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<Menu> foods;
  late List<Menu> drinks;
  String menuActive = "foods";

  @override
  void initState() {
    setState(() {
      foods = widget.restaurant.foods;
      drinks = widget.restaurant.drinks;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.restaurant.id,
                    child: Container(
                      height: 256,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.restaurant.pictureId),
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
                    child: Text(
                      widget.restaurant.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .apply(color: primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
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
                          widget.restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .apply(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.restaurant.description,
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
                            style: Theme.of(context).textTheme.subtitle2!.apply(
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
                            style: Theme.of(context).textTheme.subtitle2!.apply(
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
                      height: 350,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: menuActive == "foods"
                            ? foods.length
                            : drinks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  menuActive == "foods"
                                      ? Icons.food_bank
                                      : Icons.local_drink,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(menuActive == "foods"
                                    ? foods[index].name
                                    : drinks[index].name),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
