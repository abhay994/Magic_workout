import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/ui/sets_screen/widgets/workout_set_dialog.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';

class WorkoutSetDetailsWidget extends ConsumerWidget {
  final SetsModel setsModel;
  final int index;

  const WorkoutSetDetailsWidget({
    super.key,
    required this.setsModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder:
              (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SizedBox(
                  height: 300,
                  child: WorkoutSetDialog(
                    setsModel: setsModel,
                    setNumber: index,
                    newSet: false,
                  ),
                ),
              ),
        );
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(setsModel.exercise.toString()),
              subtitle: Column(
                children: [
                  Text('Weight: ${setsModel.weight.toString()}'),
                  Text('Repetitions: ${setsModel.repetitions.toString()}'),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                ref.read(setsProvider.notifier).removeSet(index);
              },
              icon: Icon(Icons.delete, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
