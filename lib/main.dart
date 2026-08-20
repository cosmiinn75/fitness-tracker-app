import 'package:fitness_mvp/data/api/api_client.dart';
import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/auth_controller.dart';
import 'package:fitness_mvp/data/controller/exercise_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/data/repository/auth_repository.dart';
import 'package:fitness_mvp/data/storage/active_workout_storage.dart';
import 'package:fitness_mvp/data/storage/token_storage.dart';
import 'package:fitness_mvp/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/no_white_flash_transitiona.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  final sharedPreferences = await SharedPreferences.getInstance();
  final activeWorkoutStorage =ActiveWorkoutStorage(sharedPreferences: sharedPreferences);

  
  final secureStorage = FlutterSecureStorage();
  final tokenStorage = TokenStorage(secureStorage: secureStorage);

  
  final apiClient = ApiClient(baseUrl: "http://192.168.31.194:8080/api", tokenStorage: tokenStorage, client: http.Client());
  final authRepository = AuthRepository(apiClient: apiClient, tokenStorage: tokenStorage);


  final workoutHistoryController = WorkoutHistoryController();
  final exerciseController = ExerciseController();
  final authController = AuthController(authRepository: authRepository);

  final activeWorkoutController = ActiveWorkoutController(activeWorkoutStorage: activeWorkoutStorage , workoutHistoryController: workoutHistoryController);

  activeWorkoutController.loadActiveWorkout();

  runApp(MyApp(activeWorkoutController: activeWorkoutController ,workoutHistoryController: workoutHistoryController,exerciseController: exerciseController,authController: authController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.activeWorkoutController , required this.workoutHistoryController, required this.exerciseController, required this.authController});

  final ActiveWorkoutController activeWorkoutController;
  final WorkoutHistoryController workoutHistoryController;
  final ExerciseController exerciseController;
  final AuthController authController;

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
      home: LoginPage(authController: authController,activeWorkoutController: activeWorkoutController,workoutHistoryController: workoutHistoryController,exerciseController: exerciseController,)
      // home: HomePage(activeWorkoutController : activeWorkoutController, workoutHistoryController: workoutHistoryController, exerciseController: exerciseController,),
    );
  }
}



