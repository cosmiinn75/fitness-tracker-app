import 'package:fitness_mvp/data/model/workout_draft.dart';

class WorkoutHistoryController {

  final List<WorkoutDraft> workouts = [];

  void addWorkout(WorkoutDraft workout){
    workouts.insert(0, workout);
  }

  List<WorkoutDraft> getWorkoutsForExercise(int exerciseId){
    return workouts.where(
        (workout) {
          return workout.exercises.any((exercise) => exercise.exerciseDefinition.id == exerciseId);
        }
    ).toList();
  }

}