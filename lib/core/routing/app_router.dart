
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_screen.dart';
import 'package:magic_workout/ui/sets_screen/sets_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(

    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const WorkoutListScreen(),

      ),
      GoRoute(
        path: '/workout',
        name: 'new_workout',
        builder: (context, state) => const WorkoutScreen(),
      ),
      GoRoute(
        path: '/workout/:id',
        name: 'edit_workout',
        builder: (context, state) {
          final workoutId = state.pathParameters['id']!;
          return WorkoutScreen(id: int.tryParse(workoutId));

        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(
            child: Text('Page not found'),
          ),
        ),
  );
});