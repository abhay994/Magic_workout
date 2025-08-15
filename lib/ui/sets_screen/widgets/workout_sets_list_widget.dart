import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_workout/ui/sets_screen/widgets/workout_empty_sets_widget.dart';
import 'package:magic_workout/ui/sets_screen/widgets/workout_set_details_widget.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';

class WorkoutSetsListWidget extends ConsumerStatefulWidget {
  const WorkoutSetsListWidget({super.key});

  @override
  ConsumerState createState() => _WorkoutSetsListWidgetState();
}

class _WorkoutSetsListWidgetState extends ConsumerState<WorkoutSetsListWidget> {

  
  @override
  Widget build(BuildContext context) {

     final sets = ref.watch(setsProvider);
     return sets.isNotEmpty
        ? ListView.builder(
      itemBuilder: (context, i) {
        return WorkoutSetDetailsWidget(setsModel: sets[i], index: i);
      },
      itemCount: sets.length,
       controller: ref.read(setsProvider.notifier).scrollController,
    )
        : WorkoutEmptySetsWidget();
  }
}

