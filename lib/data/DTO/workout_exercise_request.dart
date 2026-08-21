
  import 'package:fitness_mvp/data/DTO/exercise_set_request.dart';
import 'package:fitness_mvp/data/DTO/exercise_set_response.dart';
  import 'package:fitness_mvp/data/model/exercise_definition.dart';
  import 'package:fitness_mvp/data/model/exercise_set_draft.dart';

  class WorkoutExerciseRequest {
  int exerciseDefinitionId;
  final List<ExerciseSetRequest> sets;

    WorkoutExerciseRequest({required this.exerciseDefinitionId,required this.sets});






      Map<String, dynamic> toJson() {
        Map<String, dynamic> json = {};

        json['exerciseDefinitionId'] = exerciseDefinitionId;
        json['setRequests'] = sets.map((set) => set.toJson()).toList();

        return json;
      }


  }


