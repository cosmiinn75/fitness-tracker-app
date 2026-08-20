import 'dart:convert';

import 'package:fitness_mvp/data/DTO/create_exercise_request.dart';
import 'package:fitness_mvp/data/api/api_client.dart';
import 'package:fitness_mvp/data/model/exercise_definition.dart';

class ExerciseDefinitionRepository {
  final ApiClient apiClient;

  ExerciseDefinitionRepository({required this.apiClient});

  Future<List<ExerciseDefinition>> getAllExercises() async {
    final response = await apiClient.get("/exercises");

    if (response.statusCode != 200) {
      throw Exception("Failed to load exercises.");
    }

    final List<dynamic> json = jsonDecode(response.body);

    final List<ExerciseDefinition> exercises = json
        .map((e) => ExerciseDefinition.fromJson(e as Map<String, dynamic>))
        .toList();

    if (exercises.isEmpty) {
      throw Exception("No exercises received from server.");
    }

    return exercises;
  }

  Future<ExerciseDefinition> createExerciseDefinition(
    CreateExerciseRequest request,
  ) async {
    final response = await apiClient.post(
      "/exercises",
      body: request.toJson(),
    );

    if (response.statusCode == 201) {
      return ExerciseDefinition.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception("Failed to create exercise.");
    }
  }
}
