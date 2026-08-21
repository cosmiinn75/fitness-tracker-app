import 'package:fitness_mvp/data/DTO/workout_exercise_request.dart';
import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';

class WorkoutRequest {
  String workoutName;
  DateTime date;
  List<WorkoutExerciseRequest> exercises;

 WorkoutRequest({required this.exercises, required this.workoutName , required this.date});



  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['workoutName'] = workoutName;
    json['date'] = date.toIso8601String();
    json['exerciseRequests'] = exercises
        .map((exercise) => exercise.toJson())
        .toList();
    return json;
  }


}
