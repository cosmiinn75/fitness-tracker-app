class ExerciseSetDraft {
  int setNumber;
  double? weight;
  int? reps;
  int? rir;

  ExerciseSetDraft({required this.setNumber, this.weight, this.reps, this.rir});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['setNumber'] = setNumber;
    json['weight'] = weight;
    json['reps'] = reps;
    json['rir'] = rir;

    return json;
  }

  factory ExerciseSetDraft.fromJson(Map<String, dynamic> json) {
    return ExerciseSetDraft(
      setNumber: (json['setNumber'] as num?)?.toInt() ?? 1,
      weight: (json['weight'] as num?)?.toDouble(),
      reps: (json['reps'] as num?)?.toInt(),
      rir: (json['rir'] as num?)?.toInt(),
    );
  }
}
