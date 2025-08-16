import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_workout/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests', () {

    setUp(() async {
      // Initialize with mock values
      SharedPreferences.setMockInitialValues({
        'JsonData': '[]',
      });
    });

    testWidgets('Complete workout flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Should start at workout list screen
      expect(find.text('My Workout'), findsOneWidget);

      // Tap FAB to create new workout
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Should be on workout screen
      expect(find.text('New Workout'), findsOneWidget);

      // Enter workout name
      await tester.enterText(find.byType(TextField).first, 'Push Day');
      await tester.pump();

      // Add first set
      await tester.tap(find.text('Add Set'));
      await tester.pump();

      // Tap the dropdown button to open the menu
      await tester.tap(find.byKey(const Key('select-exercise')));
      await tester.pumpAndSettle();

      // Tap the desired item
      await tester.tap(find.byKey(const Key('exercise-Deadlift')));
      await tester.pumpAndSettle();

      // Enter weight
      await tester.enterText(find.byKey(const Key('weight')), '20');
      await tester.pump();

      // Enter repetition
      await tester.enterText(find.byKey(const Key('repetition')), '5');
      await tester.pump();

      // Tap the save to the set
      await tester.tap(find.byKey(const Key('save-set')));
      await tester.pump();

      // Tap the save to the set
      await tester.tap(find.byKey(const Key('save-workout')));
      await tester.pump();

    });

    testWidgets('Complete workout flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Should start at workout list screen
      expect(find.text('My Workout'), findsOneWidget);

      // Tap FAB to create new workout
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Should be on workout screen
      expect(find.text('New Workout'), findsOneWidget);

      // Enter workout name
      await tester.enterText(find.byType(TextField).first, 'Push Day');
      await tester.pump();

      // Add first set
      await tester.tap(find.text('Add Set'));
      await tester.pump();

      // Tap the dropdown button to open the menu
      await tester.tap(find.byKey(const Key('select-exercise')));
      await tester.pumpAndSettle();

      // Tap the desired item
      await tester.tap(find.byKey(const Key('exercise-Deadlift')));
      await tester.pumpAndSettle();

      // Enter weight
      await tester.enterText(find.byKey(const Key('weight')), '20');
      await tester.pump();

      // Enter repetition
      await tester.enterText(find.byKey(const Key('repetition')), '5');
      await tester.pump();

      // Tap the save to the set
      await tester.tap(find.byKey(const Key('save-set')));
      await tester.pump();

      // Tap the save to the set
      await tester.tap(find.byKey(const Key('save-workout')));
      await tester.pump();

    });


  });

}