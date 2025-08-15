import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout/core/routing/app_router.dart';
import 'package:magic_workout/main.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_screen.dart';
import 'package:magic_workout/ui/sets_screen/sets_screen.dart';

void main() {
  group('Widget Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('App should display workout list screen', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child:MagicWorkoutApp()));
      final appBarText = find.byKey(const ValueKey('workoutListTitle'));

      // Assert that one widget with this key is found
      expect(appBarText, findsOneWidget);

      // Assert its content
      expect(tester.widget<Text>(appBarText).data, 'My Workout');

      // Assert that one widget with FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });


    testWidgets('Should show empty state when no workouts', (tester) async {
      await tester.pumpWidget(const ProviderScope(child:const MaterialApp(
        home: WorkoutListScreen(),
      )));

      // Assert its content
      expect(find.text('No workouts recorded yet.\nTap + to add your first workout!'),
          findsOneWidget);
    });

    testWidgets('Should navigate to workout screen when FAB is tapped', (tester) async {

      await tester.pumpWidget( ProviderScope(child: MaterialApp.router(
         routerConfig: container.read(routerProvider),
      )));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('New Workout'), findsOneWidget);
      expect(find.text('Workout Name'), findsOneWidget);
    });


    testWidgets('Workout screen should able to add sets', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(
        home: WorkoutScreen(),
      )));

      expect(find.text('New Workout'), findsOneWidget);
      expect(find.text('Workout Name'), findsOneWidget);
      expect(find.text('Add Set'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('Workout screen should have name input and add set button', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(
        home: WorkoutScreen(),
      )));
      await tester.tap(find.text('Add Set'));
      await tester.pumpAndSettle();
      expect(find.text('Exercise'), findsOneWidget);
      expect(find.text('Weight (kg)'), findsOneWidget);
      expect(find.text('Repetitions'), findsOneWidget);
      expect(find.text('save'), findsOneWidget);
    });

  });



}
