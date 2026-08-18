import 'dart:convert';

import 'package:fitness_mvp/data/model/workout_draft.dart';
import 'package:fitness_mvp/helper/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveWorkoutStorage {

  final SharedPreferences sharedPreferences;

  ActiveWorkoutStorage({required this.sharedPreferences});


  Future<void> saveActiveWorkout(WorkoutDraft workout) async{

    await sharedPreferences.setString(AppConstants.ACTIVE_WORKOUT, jsonEncode(workout.toJson()));

  }

  WorkoutDraft? loadActiveWorkout(){

    final String? workoutJson = sharedPreferences.getString(AppConstants.ACTIVE_WORKOUT);

    if(workoutJson == null){
      return null;
    }

    final Map<String,dynamic> json = jsonDecode(workoutJson) as Map<String,dynamic>;

    return WorkoutDraft.fromJson(json);

  }

  Future<void> deleteActiveWorkout() async{
    await sharedPreferences.remove(AppConstants.ACTIVE_WORKOUT);
  }

}