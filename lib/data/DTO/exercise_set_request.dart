class ExerciseSetRequest {
  double weight;
  int reps;
  int rir;

  ExerciseSetRequest({required this.weight,required this.reps, required this.rir});


  Map<String,dynamic> toJson(){
    return {
      "weight":weight,
      "reps":reps,
      "rir":rir
    };
  }
}