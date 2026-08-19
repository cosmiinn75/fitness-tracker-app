import 'package:fitness_mvp/data/model/exercise_definition.dart';

class ExerciseController {

  List<ExerciseDefinition> exercises = [
    ExerciseDefinition(
      id: 1,
      name: "Bench Press",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 2,
      name: "Incline Bench Press",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 3,
      name: "Dumbbell Fly",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 4,
      name: "Lat Pulldown",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 5,
      name: "Barbell Row",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 6,
      name: "Pull Up",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 7,
      name: "Biceps Curl",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 8,
      name: "Hammer Curl",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 9,
      name: "Triceps Pushdown",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 10,
      name: "Shoulder Press",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 11,
      name: "Lateral Raise",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 12,
      name: "Rear Delt Fly",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 13,
      name: "Squat",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 14,
      name: "Leg Press",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 15,
      name: "Leg Curl",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 16,
      name: "Plank",
      muscleGroup: "Core",
    ),
    ExerciseDefinition(
      id: 17,
      name: "Crunch",
      muscleGroup: "Core",
    ),
    ExerciseDefinition(
      id: 18,
      name: "Hanging Leg Raise",
      muscleGroup: "Core",
    ),
  ];

  void addExercise(ExerciseDefinition exerciseDefinition){
    exercises.add(exerciseDefinition);
  }

  bool exerciseExists(String name,String muscleGroup){


    return exercises.any(
        (exercise) => exercise.name.trim().toLowerCase() == name.trim().toLowerCase() && exercise.muscleGroup.trim().toLowerCase() == muscleGroup.trim().toLowerCase()
    );
  }

}