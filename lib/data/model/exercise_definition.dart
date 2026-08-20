class ExerciseDefinition {
  final int id;
  String exerciseType;
  String exerciseName;
  String muscleGroup;
  bool archived;

  ExerciseDefinition({
    required this.id,
    this.exerciseType = "SYSTEM",
    required this.exerciseName,
    required this.muscleGroup,
    this.archived = false,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['exerciseName'] = exerciseName;
    json['muscleGroup'] = muscleGroup;
    return json;
  }

  factory ExerciseDefinition.fromJson(Map<String, dynamic> json) {
    return ExerciseDefinition(
      id: json['id'],
      exerciseName: json['exerciseName'],
      exerciseType: json['exerciseType'] ?? 'SYSTEM',
      archived: json['archived'] ?? false,
      muscleGroup: json['muscleGroup'],
    );
  }
}
