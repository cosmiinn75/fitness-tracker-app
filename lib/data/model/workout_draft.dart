import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';

class WorkoutDraft {
  String workoutName;
  DateTime date;
  List<WorkoutExerciseDraft> exercises;

  WorkoutDraft({
    required this.workoutName,
    required this.date,
    required this.exercises,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['workoutName'] = workoutName;
    json['date'] = date.toIso8601String();
    json['workoutExercises'] = exercises
        .map((exercise) => exercise.toJson())
        .toList();
    return json;
  }

  factory WorkoutDraft.fromJson(Map<String, dynamic> json) {
    return WorkoutDraft(
      workoutName: json['workoutName'],
      date:  DateTime.parse(json['date']),
      exercises: (json['workoutExercises'] as List)
          .map(
            (exerciseJson) => WorkoutExerciseDraft.fromJson(
              exerciseJson as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
