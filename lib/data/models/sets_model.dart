enum Exercise {
  barbellRow('Barbell row'),
  benchPress('Bench press'),
  shoulderPress('Shoulder press'),
  deadlift('Deadlift'),
  squat('Squat');

  const Exercise(this.displayName);
  final String displayName;

}

class SetsModel{
  String? exercise;
  double? weight;
  int? repetitions;

  SetsModel({
    this.exercise,
    this.weight,
    this.repetitions,
  });

  SetsModel copyWith({
    String? exercise,
    double? weight,
    int? repetitions,
  }) {
    return SetsModel(
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }

  factory SetsModel.fromJson(Map<String, dynamic> json) {
    return SetsModel(
      exercise: json['exercise'],
      weight: json['weight'].toDouble(),
      repetitions: json['repetitions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise,
      'weight': weight,
      'repetitions': repetitions,
    };
  }
}