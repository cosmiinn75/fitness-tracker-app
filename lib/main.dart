import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/data/storage/active_workout_storage.dart';
import 'package:fitness_mvp/pages/home/home_page.dart';
import 'package:fitness_mvp/pages/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/no_white_flash_transitiona.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final activeWorkoutStorage =ActiveWorkoutStorage(sharedPreferences: sharedPreferences);

  final workoutHistoryController = WorkoutHistoryController();

  final activeWorkoutController = ActiveWorkoutController(activeWorkoutStorage: activeWorkoutStorage , workoutHistoryController: workoutHistoryController);

  activeWorkoutController.loadActiveWorkout();

  runApp(MyApp(activeWorkoutController: activeWorkoutController ,workoutHistoryController: workoutHistoryController,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.activeWorkoutController , required this.workoutHistoryController});

  final ActiveWorkoutController activeWorkoutController;
  final WorkoutHistoryController workoutHistoryController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness MVP',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(

          builders: {

            TargetPlatform.android: NoWhiteFlashTransition(),

            TargetPlatform.iOS: NoWhiteFlashTransition(),

            TargetPlatform.windows: NoWhiteFlashTransition(),

            TargetPlatform.linux: NoWhiteFlashTransition(),

            TargetPlatform.macOS: NoWhiteFlashTransition(),

          },

        ),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(activeWorkoutController : activeWorkoutController, workoutHistoryController: workoutHistoryController),
    );
  }
}



