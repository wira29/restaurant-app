import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/textTheme.dart';
import 'package:restaurant_app/data/services/ApiService.dart';
import 'package:restaurant_app/provider/RestaurantProvider.dart';
import 'package:restaurant_app/ui/DetailScreen.dart';
import 'package:restaurant_app/ui/HomeScreen.dart';
import 'package:restaurant_app/ui/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
          textTheme: myTextTheme),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestaurantProvider(apiService: ApiService()),
              child: HomeScreen(),
            ),
        DetailScreen.routeName: (context) => DetailScreen(
            id: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
