import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/model/exercise_set_draft.dart';
import 'package:fitness_mvp/data/model/workout_draft.dart';
import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';
import 'package:fitness_mvp/data/storage/active_workout_storage.dart';

class ActiveWorkoutController {

  WorkoutDraft? activeWorkout;
  final ActiveWorkoutStorage activeWorkoutStorage;

  ActiveWorkoutController({ required this.activeWorkoutStorage, this.activeWorkout});

  void saveActiveWorkout(){
    if(activeWorkout == null){
      return;
    }

    activeWorkoutStorage.saveActiveWorkout(activeWorkout!);
  }

  void loadActiveWorkout(){
    activeWorkout = activeWorkoutStorage.loadActiveWorkout();
  }

  void deleteActiveWorkout(){
    activeWorkout = null;

    activeWorkoutStorage.deleteActiveWorkout();
  }


  void startWorkout() {
    activeWorkout = WorkoutDraft(
      workoutName: "New Workout",
      date: DateTime.now(),
      exercises: [],
    );

    saveActiveWorkout();
  }

  void addExercises(List<ExerciseDefinition> newExercises){
    for(int i = 0 ; i < newExercises.length ; i++){
      activeWorkout!.exercises.add(WorkoutExerciseDraft(exerciseNumber: activeWorkout!.exercises.length + 1, sets: [
        ExerciseSetDraft(setNumber: 1),
        ExerciseSetDraft(setNumber: 2)
      ], exerciseDefinition: newExercises[i]));
    }
    saveActiveWorkout();
  }

  void removeExercise(int index){

    activeWorkout!.exercises.removeAt(index);

    for(int i = index ; i < activeWorkout!.exercises.length ; i++){
      activeWorkout!.exercises[i].exerciseNumber = i+1;
    }
    saveActiveWorkout();
  }

  void addSet(WorkoutExerciseDraft exercise){
    for (var ex in activeWorkout!.exercises) {
      if(ex == exercise){
       ex.sets.add(ExerciseSetDraft(setNumber: ex.sets.length+1));
       break;
      }
    }
    saveActiveWorkout();
  }

  void removeSet(WorkoutExerciseDraft exercise, int index){
    for (var ex in activeWorkout!.exercises) {
      if(ex == exercise){
        ex.sets.removeAt(index);

        for(int i = index ; i < ex.sets.length ; i++){
          ex.sets[i].setNumber = i+1;
        }


        break;
      }

    }
    saveActiveWorkout();
  }

  void updateWeight(WorkoutExerciseDraft exercise,int index,double? weight){
    for (var ex in activeWorkout!.exercises) {
      if(ex == exercise){
        ex.sets[index].weight = weight;
        break;
      }

    }
    saveActiveWorkout();
  }

  void updateReps(WorkoutExerciseDraft exercise,int index,int? reps){
    for (var ex in activeWorkout!.exercises) {
      if(ex == exercise){
        ex.sets[index].reps = reps;
        break;
      }

    }
    saveActiveWorkout();
  }
  void updateRir(WorkoutExerciseDraft exercise,int index,int? rir){
    for (var ex in activeWorkout!.exercises) {
      if(ex == exercise){
        ex.sets[index].rir= rir ;
        break;
      }

    }
    saveActiveWorkout();
  }


}