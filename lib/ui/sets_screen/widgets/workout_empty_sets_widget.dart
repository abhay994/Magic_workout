import 'package:flutter/material.dart';
class WorkoutEmptySetsWidget extends StatefulWidget {
  const WorkoutEmptySetsWidget({super.key});

  @override
  State<WorkoutEmptySetsWidget> createState() => _WorkoutEmptySetsWidgetState();
}

class _WorkoutEmptySetsWidgetState extends State<WorkoutEmptySetsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No sets added yet.\nTap "Add Set" to get started!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
