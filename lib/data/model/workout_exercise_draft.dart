import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/model/exercise_set_draft.dart';

class WorkoutExerciseDraft {
  int exerciseNumber;
  final List<ExerciseSetDraft> sets;
  final ExerciseDefinition exerciseDefinition;

  WorkoutExerciseDraft({
    required this.exerciseNumber,
    required this.sets,
    required this.exerciseDefinition,
  });

  void addSet(ExerciseSetDraft newSet) {
    sets.add(newSet);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['exerciseNumber'] = exerciseNumber;
    json['exerciseSets'] = sets.map((set) => set.toJson()).toList();
    json['exerciseDefinition'] = exerciseDefinition.toJson();

    return json;
  }

  factory WorkoutExerciseDraft.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseDraft(
      exerciseNumber: json['exerciseNumber'],
      sets: (json['exerciseSets'] as List)
          .map((setJson) => ExerciseSetDraft.fromJson(setJson as Map<String,dynamic>))
          .toList(),
      exerciseDefinition: ExerciseDefinition.fromJson(
        json['exerciseDefinition'] as Map<String,dynamic>
      ),
    );
  }
}
