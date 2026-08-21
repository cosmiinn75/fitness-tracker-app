import 'package:fitness_mvp/data/DTO/workout_response.dart';
import 'package:fitness_mvp/data/repository/workout_repository.dart';

class WorkoutHistoryController {

  final WorkoutRepository workoutRepository;

  final List<WorkoutResponse> workouts = [];
  int currentPage = 0;
  bool last = false;
  bool isLoading = false;

    WorkoutHistoryController({required this.workoutRepository});

    Future<void> loadWorkouts({String? name , DateTime? startDate, DateTime? endDate}) async{

      if(isLoading || last){
        return;
      }

     try{
       isLoading = true;

       final response =await workoutRepository.getAllWorkouts(currentPage, 20, name: name, startDate: startDate,endDate: endDate);

       workouts.addAll(response.content);

       currentPage++;
       last = response.last;
     }finally
     {isLoading = false;}

    }


  List<WorkoutResponse> getWorkoutsForExercise(String exerciseName){
    return workouts.where(
        (workout) {
          return workout.exercises.any((exercise) => exercise.exerciseName == exerciseName);
        }
    ).toList();
  }

    Future<void> reloadWorkouts({String? name , DateTime? startDate, DateTime? endDate}) async{

      workouts.clear();
      currentPage = 0 ;
      last = false;

      await loadWorkouts(name: name,startDate: startDate,endDate: endDate);

    }

}