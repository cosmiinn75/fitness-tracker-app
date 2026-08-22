import 'package:fitness_mvp/data/DTO/create_exercise_request.dart';
import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/repository/exercise_definition_repository.dart';

class ExerciseDefinitionController {

  final ExerciseDefinitionRepository exerciseDefinitionRepository;
  List<ExerciseDefinition> exercises = [];

  ExerciseDefinitionController({required this.exerciseDefinitionRepository});

  Future<void> getAllExercises() async{
    exercises = await exerciseDefinitionRepository.getAllExercises();
  }

  Future<ExerciseDefinition> createExercise(CreateExerciseRequest newExercise) async {
    final exercise =  await exerciseDefinitionRepository.createExerciseDefinition(newExercise);

    exercises.add(exercise);
    return exercise;
  }

  void clearExercises(){
    exercises.clear();
  }



    bool exerciseExists(String name,String muscleGroup){


      return exercises.any(
              (exercise) => exercise.exerciseName.trim().toLowerCase() == name.trim().toLowerCase() && exercise.muscleGroup.trim().toLowerCase() == muscleGroup.trim().toLowerCase()
      );
  }

}