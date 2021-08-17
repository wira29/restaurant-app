import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/preferences.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                    "Settings",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurant Notification",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            "Enable Notification",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Container(
                        child: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                          return Switch.adaptive(
                              value: scheduled.isScheduled,
                              onChanged: (val) {
                                if (Platform.isAndroid) {
                                  Preferences().setNotif(val);
                                  scheduled.scheduledRestaurant(val);
                                }
                              });
                        }),
                      )
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
