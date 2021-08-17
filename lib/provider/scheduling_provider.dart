import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  SchedulingProvider() {
    getSharedPreferences();
  }

  void getSharedPreferences() async {
    _isScheduled = await Preferences().getNotification();
    notifyListeners();
    scheduledRestaurant(_isScheduled);
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print("Scheduling Restaurant Active");
      notifyListeners();

      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print("Scheduling Restaurant Canceled");
      notifyListeners();
      return AndroidAlarmManager.cancel(1);
    }
  }
}
