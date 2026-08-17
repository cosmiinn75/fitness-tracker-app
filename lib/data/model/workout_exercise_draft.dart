import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/model/exercise_set_draft.dart';

class WorkoutExerciseDraft {

  final int exerciseNumber;
  final List<ExerciseSetDraft> _sets;
  final ExerciseDefinition exerciseDefinition;

  List<ExerciseSetDraft> get sets=>_sets;

  WorkoutExerciseDraft({ required this.exerciseNumber , required this._sets , required this.exerciseDefinition});


  void addSet(ExerciseSetDraft newSet){
    _sets.add(newSet);
  }

}