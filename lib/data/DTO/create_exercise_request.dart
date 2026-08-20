class CreateExerciseRequest {

  String exerciseName;
  String muscleGroup;


  CreateExerciseRequest({
    required this.exerciseName,
    required this.muscleGroup,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['exerciseName'] = exerciseName;
    json['muscleGroup'] = muscleGroup;
    return json;
  }


}