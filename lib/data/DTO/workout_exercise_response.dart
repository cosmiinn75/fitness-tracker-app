import 'package:fitness_mvp/data/DTO/exercise_set_response.dart';
import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/model/exercise_set_draft.dart';

class WorkoutExerciseResponse {
  int id;
  int exerciseNumber;
  final List<ExerciseSetResponse> sets;
  final String exerciseName;

  WorkoutExerciseResponse({
    required this.id ,
    required this.exerciseNumber,
    required this.sets,
    required this.exerciseName,
  });




  factory WorkoutExerciseResponse.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseResponse(
      id: json['id'],
      exerciseNumber: json['exerciseNumber'],
      sets: (json['setResponses'] as List)
          .map((setJson) => ExerciseSetResponse.fromJson(setJson as Map<String,dynamic>))
          .toList(),
      exerciseName:  json['exerciseName']
    );
  }
}
