import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/data/models/workout_model.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('workouts list viewmodel', () {
    late ProviderContainer container;
    late WorkoutModel workoutModel;

    setUp(() {
      container = ProviderContainer();

      workoutModel = WorkoutModel(
        name: 'cardio',
        id: '01',
        date: DateTime.now(),
        setsList: [
          SetsModel(exercise: 'Bench press', weight: 15, repetitions: 2),
          SetsModel(exercise: 'Squat', weight: 15, repetitions: 2),
        ],
      );

      container.read(workoutListProvider).add(workoutModel);
    });

    tearDown(() {
      container.dispose();
    });

    test('should generate unique workout IDs', () async {
      final id1 = container.read(workoutListProvider.notifier).generateId();
      final id2 = container.read(workoutListProvider.notifier).generateId();
      await Future.delayed(const Duration(seconds: 1));
      expect(id1, isNot(equals(id2)));
      expect(id1, isNotEmpty);
      expect(id2, isNotEmpty);
    });

    test('should generate DateTime', () {
      final dateTime =
          container.read(workoutListProvider.notifier).generateDate();

      expect(dateTime.month, DateTime.now().month);
      expect(dateTime.day, DateTime.now().day);
      expect(dateTime.year, DateTime.now().year);
    });

    test('should add new workout in list', () {
      List<WorkoutModel> workoutList = container.read(workoutListProvider);

      expect(workoutList[0].name, workoutModel.name);
      expect(workoutList[0].id, workoutModel.id);
      expect(workoutList[0].date.year, workoutModel.date.year);
      expect(workoutList[0].setsList.length, workoutModel.setsList.length);
    });

    test('should remove workout from list', () {
      container.read(workoutListProvider.notifier).removeWorkout(0);
      List<WorkoutModel> workoutList = container.read(workoutListProvider);

      expect(workoutList.length, 0);
    });
  });

  group('Sets viewmodel', () {
    late ProviderContainer container;

    late SetsModel setsModel;
    setUp(() {
      container = ProviderContainer();
      setsModel = SetsModel(exercise: 'Bench press', weight: 15, repetitions: 2);

      container.read(setsProvider).add(setsModel);
    });

    tearDown(() {
      container.dispose();
    });

    test('should add new sets in list', () {
      List<SetsModel> currentSetsModel = container.read(setsProvider);

      expect(currentSetsModel[0].weight, setsModel.weight);
      expect(currentSetsModel[0].repetitions, setsModel.repetitions);
      expect(currentSetsModel[0].exercise, setsModel.exercise);
    });

    test('should remove workout from list', () {
      container.read(setsProvider.notifier).removeSet(0);
      List<SetsModel> currentSetsModel = container.read(setsProvider);

      expect(currentSetsModel.length, 0);
    });
  });


  group('Sets Model', () {
    test('should create a workout set with correct values', () {
      final set = SetsModel(
        exercise: 'Bench press',
        weight: 50.0,
        repetitions: 10,
      );

      expect(set.exercise, 'Bench press');
      expect(set.weight, 50.0);
      expect(set.repetitions, 10);
    });

    test('should convert to and from JSON correctly', () {
      final originalSet = SetsModel(
        exercise: 'Deadlift',
        weight: 80.0,
        repetitions: 8,
      );

      final json = originalSet.toJson();
      final reconstructedSet = SetsModel.fromJson(json);

      expect(reconstructedSet.exercise, originalSet.exercise);
      expect(reconstructedSet.weight, originalSet.weight);
      expect(reconstructedSet.repetitions, originalSet.repetitions);
    });

    test('should create a copy with updated values', () {
      final originalSet = SetsModel(
        exercise: 'Squat',
        weight: 60.0,
        repetitions: 12,
      );

      final copiedSet = originalSet.copyWith(weight: 70.0, repetitions: 10);

      expect(copiedSet.exercise, 'Squat');
      expect(copiedSet.weight, 70.0);
      expect(copiedSet.repetitions, 10);
    });
  });


  group('Workout Model', () {
    test('should create a workout with correct values', () {
      final date = DateTime(2024, 1, 15);
      final sets = [
        SetsModel(exercise: 'Bench press', weight: 50.0, repetitions: 10),
        SetsModel(exercise: 'Deadlift', weight: 80.0, repetitions: 8),
      ];

      final workout = WorkoutModel(
        id: '123',
        name: 'Upper Body',
        date: date,
        setsList: sets,
      );

      expect(workout.id, '123');
      expect(workout.name, 'Upper Body');
      expect(workout.date, date);
      expect(workout.setsList.length, 2);
    });

    test('should convert to and from JSON correctly', () {
      final originalWorkout = WorkoutModel(
        id: '456',
        name: 'Lower Body',
        date: DateTime(2024, 1, 16),
        setsList: [SetsModel(exercise: 'Squat', weight: 70.0, repetitions: 12)],
      );

      final json = originalWorkout.toJson();
      final reconstructedWorkout = WorkoutModel.fromJson(json);

      expect(reconstructedWorkout.id, originalWorkout.id);
      expect(reconstructedWorkout.name, originalWorkout.name);
      expect(reconstructedWorkout.date, originalWorkout.date);
      expect(
        reconstructedWorkout.setsList.length,
        originalWorkout.setsList.length,
      );
      expect(reconstructedWorkout.setsList.first.exercise, 'Squat');
    });
  });
}
