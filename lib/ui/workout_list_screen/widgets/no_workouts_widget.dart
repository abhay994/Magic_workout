import 'package:flutter/material.dart';

class NoWorkoutsWidget extends StatelessWidget {
  const NoWorkoutsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No workouts recorded yet.\nTap + to add your first workout!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
