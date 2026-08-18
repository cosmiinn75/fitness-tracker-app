import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/storage/active_workout_storage.dart';
import 'package:fitness_mvp/pages/home/home_page.dart';
import 'package:fitness_mvp/pages/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final activeWorkoutStorage =ActiveWorkoutStorage(sharedPreferences: sharedPreferences);

  final activeWorkoutController = ActiveWorkoutController(activeWorkoutStorage: activeWorkoutStorage);

  activeWorkoutController.loadActiveWorkout();

  runApp(MyApp(activeWorkoutController: activeWorkoutController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.activeWorkoutController});

  final ActiveWorkoutController activeWorkoutController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness MVP',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(activeWorkoutController : activeWorkoutController),
    );
  }
}



