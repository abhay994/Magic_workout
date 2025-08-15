import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:magic_workout/ui/workout_list_screen/widgets/no_workouts_widget.dart';
import 'package:magic_workout/ui/workout_list_screen/widgets/workout_card.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';
class WorkoutListWidget extends ConsumerWidget {
  const WorkoutListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  workoutList = ref.watch(workoutListProvider);

    return workoutList.isNotEmpty
        ? ListView.builder(
      itemBuilder: (context, i) {
        return WorkoutCard(name: workoutList[i].name,
            dateTime: workoutList[i].date,
            setCnt: workoutList[i].setsList.length,
            index:i,

        );
      },
      itemCount: workoutList.length,
      controller: ref.read(setsProvider.notifier).scrollController,
    )
        : NoWorkoutsWidget();
  }
  }
