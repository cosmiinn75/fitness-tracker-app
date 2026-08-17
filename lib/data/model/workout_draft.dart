import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';

class WorkoutDraft {

  String workoutName;
  DateTime date;
  List<WorkoutExerciseDraft> exercises;


  WorkoutDraft({required this.workoutName, required this.date , required this.exercises });

}