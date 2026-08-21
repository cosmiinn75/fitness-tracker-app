
import 'package:fitness_mvp/data/DTO/workout_exercise_response.dart';

class WorkoutResponse{
  int id;
  String workoutName;
  DateTime date;
  List<WorkoutExerciseResponse> exercises;

  WorkoutResponse({
    required this.id,
    required this.workoutName,
    required this.date,
    required this.exercises,
  });


  factory WorkoutResponse.fromJson(Map<String, dynamic> json) {
    return WorkoutResponse(
    id: json['id'],
      workoutName: json['workoutName'],
      date:  DateTime.parse(json['date']),
      exercises: (json['exerciseResponses'] as List)
          .map(
            (exerciseJson) => WorkoutExerciseResponse.fromJson(
          exerciseJson as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}
