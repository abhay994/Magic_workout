import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';

class WorkoutCard extends ConsumerWidget {
  final String name;
  final DateTime dateTime;
  final int setCnt;
  final int index;

  const WorkoutCard({
    super.key,
    required this.name,
    required this.dateTime,
    required this.setCnt,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
            Text('$setCnt sets'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed:
              () => ref.read(workoutListProvider.notifier).removeWorkout(index),
        ),
        onTap: () => context.go('/workout/$index'),
      ),
    );
  }
}
