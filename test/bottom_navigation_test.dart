import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/bottom_nav.dart';

Widget bottomNavigation() => ChangeNotifierProvider(
    create: (_) => SchedulingProvider(), child: MaterialApp(home: BottomNav()));

void main() {
  group('Module Test BottomNavigation Widget', () {
    testWidgets('Testing BottomNavigationBar Widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(bottomNavigation());
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}
