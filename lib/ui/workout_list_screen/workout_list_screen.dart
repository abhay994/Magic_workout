import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout/ui/workout_list_screen/widgets/workout_list_widget.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';

class WorkoutListScreen extends ConsumerWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(workoutListProvider.notifier).loadWorkoutList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workout', key: ValueKey('workoutListTitle')),
      ),
      body: WorkoutListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/workout'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
