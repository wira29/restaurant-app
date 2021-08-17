import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/widgets/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";

  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() {
    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, BottomNav.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 80,
              color: primaryColor,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Restaurant App",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .apply(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
