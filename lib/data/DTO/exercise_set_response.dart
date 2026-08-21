class ExerciseSetResponse {
  int id;
  int setNumber;
  double? weight;
  int? reps;
  int? rir;

  ExerciseSetResponse({required this.id,required this.setNumber, this.weight, this.reps, this.rir});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["id"] = id;
    json['setNumber'] = setNumber;
    json['weight'] = weight;
    json['reps'] = reps;
    json['rir'] = rir;

    return json;
  }

  factory ExerciseSetResponse.fromJson(Map<String, dynamic> json) {
    return ExerciseSetResponse(
      id:(json['id'] as num?)?.toInt() ?? 0,
      setNumber: (json['setNumber'] as num?)?.toInt() ?? 1,
      weight: (json['weight'] as num?)?.toDouble(),
      reps: (json['reps'] as num?)?.toInt(),
      rir: (json['rir'] as num?)?.toInt(),
    );
  }
}
