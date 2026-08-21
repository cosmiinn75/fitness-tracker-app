import 'dart:convert';

import 'package:fitness_mvp/data/DTO/create_workout_response.dart';
import 'package:fitness_mvp/data/DTO/paged_response.dart';
import 'package:fitness_mvp/data/DTO/workout_request.dart';
import 'package:fitness_mvp/data/DTO/workout_response.dart';
import 'package:fitness_mvp/data/api/api_client.dart';
import 'package:fitness_mvp/data/mapper/workout_mapper.dart';
import 'package:fitness_mvp/data/model/workout_draft.dart';

class WorkoutRepository {

  final ApiClient apiClient;

  WorkoutRepository({required this.apiClient});

  Future<PagedResponse<WorkoutResponse>> getAllWorkouts(int page,int size,{String? name,DateTime? startDate, DateTime? endDate}) async{


    final Map<String,String> queryParameters = {
      "page": page.toString(),
      "size": size.toString()
    };

    if(name != null && name.trim().isNotEmpty){
      queryParameters["name"] = name.trim();
    }

    if(startDate != null){
      queryParameters["startDate"] = startDate.toIso8601String().split("T")[0];
    }

    if(endDate != null){
      queryParameters["endDate"] = endDate.toIso8601String().split("T")[0];
    }
    final Uri uri = Uri(path: "/workouts",queryParameters: queryParameters);

    final response = await apiClient.get(uri.toString());

    if(response.statusCode != 200){
      throw Exception("Something went wrong");
    }
    return PagedResponse.fromJson(jsonDecode(response.body), WorkoutResponse.fromJson);

  }


  Future<CreateWorkoutResponse> createWorkout(WorkoutDraft workoutDraft) async{
      WorkoutRequest request =WorkoutMapper.toRequest(workoutDraft);


      final response = await apiClient.post("/workouts", body: request.toJson());


      if(response.statusCode != 201){
        throw Exception("Something went wrong");
      }



      return CreateWorkoutResponse.fromJson(jsonDecode(response.body) as Map<String,dynamic>);

  }


  Future<String?> deleteWorkout(int workoutId) async {
    try {
      final response = await apiClient.delete(
        "/workouts/$workoutId",
      );

      if (response.statusCode == 204) {
        return null;
      }

      return "Could not delete workout.";
    } catch (e) {
      return "Could not connect to the server.";
    }
  }


}