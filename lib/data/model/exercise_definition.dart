class ExerciseDefinition {
  final int id;
  String type;
  String name;
  String muscleGroup;
  bool archived;

  ExerciseDefinition({
    required this.id,
    this.type = "SYSTEM",
    required this.name,
    required this.muscleGroup,
    this.archived = false,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['type'] = type;
    json['name'] = name;
    json['muscleGroup'] = muscleGroup;
    json['archived'] = archived;

    return json;
  }

  factory ExerciseDefinition.fromJson(Map<String, dynamic> json) {
    return ExerciseDefinition(
      id: json['id'],
      name: json['name'],
      type: json['type'] ?? 'SYSTEM',
      archived: json['archived'] ?? false,
      muscleGroup: json['muscleGroup'],
    );
  }
}
