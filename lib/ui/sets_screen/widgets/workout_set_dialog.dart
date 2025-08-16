import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';

class WorkoutSetDialog extends ConsumerStatefulWidget {
  final SetsModel? setsModel;
  final int? setNumber;
  final bool newSet;

  const WorkoutSetDialog({
    super.key,
    this.setsModel,
    this.setNumber,
    required this.newSet,
  });

  @override
  ConsumerState createState() => _WorkoutSetDialogState();
}

class _WorkoutSetDialogState extends ConsumerState<WorkoutSetDialog> {
  late String selectedExercise;
  late TextEditingController _weightController;
  late TextEditingController _repsController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    load();
  }

  load() {
    selectedExercise =
        widget.setsModel!.exercise ?? Exercise.benchPress.displayName;
    _weightController = TextEditingController(
      text: (widget.setsModel!.weight ?? 0).toString(),
    );
    _repsController = TextEditingController(
      text: (widget.setsModel!.repetitions ?? 0).toString(),
    );
    _weightController.addListener(_updateSets);
    _repsController.addListener(_updateSets);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _updateSets() {
    if (widget.setNumber != null) {
      ref
          .read(setsProvider.notifier)
          .updateSet(
            widget.setNumber!,
            widget.setsModel!.copyWith(
              exercise: selectedExercise,
              weight: double.tryParse(_weightController.text) ?? 0,
              repetitions: int.tryParse(_repsController.text) ?? 0,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.cancel, color: Colors.redAccent, size: 20),
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              key: ValueKey('select-exercise'),
              value: selectedExercise,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedExercise = value;
                  });
                  _updateSets();
                }
              },
              items:
                  Exercise.values.map((Exercise exercise) {
                    return DropdownMenuItem<String>(
                      key: ValueKey('exercise-${exercise.displayName}'),
                      value: exercise.displayName,
                      child: Text(exercise.displayName),
                    );
                  }).toList(),
              decoration: const InputDecoration(
                labelText: 'Exercise',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: ValueKey('weight'),
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    key: ValueKey('repetition'),
                    controller: _repsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Repetitions',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (widget.newSet)
              TextButton(
                key: ValueKey('save-set'),
                onPressed: () {
                  ref
                      .read(setsProvider.notifier)
                      .addNewSet(
                        SetsModel(
                          exercise: selectedExercise,
                          weight: double.tryParse(_weightController.text) ?? 0,
                          repetitions: int.tryParse(_repsController.text) ?? 0,
                        ),
                      );
                  context.pop();
                },
                child: Text('save'),
              ),
          ],
        ),
      ),
    );
  }
}
