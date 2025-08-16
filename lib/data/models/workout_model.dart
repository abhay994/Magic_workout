import 'package:magic_workout/data/models/sets_model.dart';

class WorkoutModel {
  String id;
  String name;
  DateTime date;
  List<SetsModel> setsList;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.date,
    required this.setsList,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'sets': setsList.map((set) => set.toJson()).toList(),
    };
  }

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      setsList: (json['sets'] as List)
              .map((setJson) => SetsModel.fromJson(setJson))
              .toList(),
    );
  }
}
