class ExerciseDefinition {
  final int id;
  String type;
  String name;
  String muscleGroup;
  bool archived;

  ExerciseDefinition({required this.id , this.type = "SYSTEM", required this.name, required this.muscleGroup , this.archived = false});



}