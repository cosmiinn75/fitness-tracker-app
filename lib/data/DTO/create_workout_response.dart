import 'package:fitness_mvp/data/DTO/workout_exercise_response.dart';

class CreateWorkoutResponse {

  int id;
  String workoutName;
  DateTime date;
  List<WorkoutExerciseResponse> exerciseResponses;
  int goalsCompleted;

  CreateWorkoutResponse(
      {required this.id, required this.workoutName, required this.date, required this.exerciseResponses, required this.goalsCompleted});


  factory CreateWorkoutResponse.fromJson(Map<String, dynamic> json) {
    return CreateWorkoutResponse(
      id: json['id'],
      workoutName: json['workoutName'],
      date:  DateTime.parse(json['date']),
      exerciseResponses: (json['exerciseResponses'] as List)
          .map(
            (exerciseJson) => WorkoutExerciseResponse.fromJson(
          exerciseJson as Map<String, dynamic>,
        ),
      )
          .toList(),
      goalsCompleted: json['goalsCompleted']
    );
  }

}