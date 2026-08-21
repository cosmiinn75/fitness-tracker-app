import 'package:fitness_mvp/data/DTO/exercise_set_request.dart';
import 'package:fitness_mvp/data/DTO/workout_exercise_request.dart';
import 'package:fitness_mvp/data/DTO/workout_request.dart';
import 'package:fitness_mvp/data/model/workout_draft.dart';

class WorkoutMapper {
  static WorkoutRequest toRequest(WorkoutDraft draft) {
    return WorkoutRequest(
      exercises: draft.exercises.map(
        (exercise) => WorkoutExerciseRequest(
          exerciseDefinitionId: exercise.exerciseDefinition.id,
          sets: exercise.sets.
          where((set)=> set.reps != null && set.reps! > 0)
          .map(
            (set) =>
                ExerciseSetRequest(weight: set.weight ?? 0, reps: set.reps!, rir: set.rir ?? 0),
          ).toList(),
        ),
      ).toList(),
      workoutName: draft.workoutName,
      date: draft.date,
    );
  }
}
