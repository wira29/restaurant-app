import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/services/api_service.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/favorites_screen.dart';
import 'package:restaurant_app/ui/home_screen.dart';
import 'package:restaurant_app/ui/setting_screen.dart';

class BottomNav extends StatefulWidget {
  static const routeName = '/bottomNav';

  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  List<Widget> screen = [
    ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: HomeScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
      child: FavoritesScreen(),
    ),
    SettingScreen(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: primaryColor,
        ),
        child: BottomNavigationBar(
          onTap: onTap,
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey[400],
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey[400],
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.grey[400],
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: "Settings",
            )
          ],
        ),
      ),
    );
  }
}
