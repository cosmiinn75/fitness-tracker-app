import 'package:fitness_mvp/data/api/api_client.dart';
import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/auth_controller.dart';

import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/controller/user_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/data/repository/auth_repository.dart';
import 'package:fitness_mvp/data/repository/exercise_definition_repository.dart';
import 'package:fitness_mvp/data/repository/user_repository.dart';
import 'package:fitness_mvp/data/repository/workout_repository.dart';
import 'package:fitness_mvp/data/storage/active_workout_storage.dart';
import 'package:fitness_mvp/data/storage/token_storage.dart';
import 'package:fitness_mvp/pages/auth/login_page.dart';
import 'package:fitness_mvp/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/no_white_flash_transitiona.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final activeWorkoutStorage = ActiveWorkoutStorage(
    sharedPreferences: sharedPreferences,
  );

  final secureStorage = FlutterSecureStorage();
  final tokenStorage = TokenStorage(secureStorage: secureStorage);

  final apiClient = ApiClient(
    baseUrl: "http://192.168.31.194:8080/api",
    tokenStorage: tokenStorage,
    client: http.Client(),
  );
  final authRepository = AuthRepository(
    apiClient: apiClient,
    tokenStorage: tokenStorage,
  );
  final exerciseDefinitionRepository = ExerciseDefinitionRepository(
    apiClient: apiClient,
  );
  final workoutRepository = WorkoutRepository(apiClient: apiClient);
  final userRepository = UserRepository(apiClient: apiClient);

  final exerciseDefinitionController = ExerciseDefinitionController(
    exerciseDefinitionRepository: exerciseDefinitionRepository,
  );
  final userController = UserController(userRepository: userRepository);

  final workoutHistoryController = WorkoutHistoryController(
    workoutRepository: workoutRepository,
  );

  final authController = AuthController(authRepository: authRepository);

  final activeWorkoutController = ActiveWorkoutController(
    activeWorkoutStorage: activeWorkoutStorage,
    workoutHistoryController: workoutHistoryController,
    workoutRepository: workoutRepository,
  );

  activeWorkoutController.loadActiveWorkout();

  if (workoutHistoryController.currentPage == 0) {
    workoutHistoryController.loadWorkouts();
  }

  runApp(
    MyApp(
      activeWorkoutController: activeWorkoutController,
      workoutHistoryController: workoutHistoryController,
      exerciseDefinitionController: exerciseDefinitionController,
      authController: authController,
      userController: userController,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.userController,
    required this.activeWorkoutController,
    required this.workoutHistoryController,
    required this.exerciseDefinitionController,
    required this.authController,
  });

  final ActiveWorkoutController activeWorkoutController;
  final WorkoutHistoryController workoutHistoryController;
  final ExerciseDefinitionController exerciseDefinitionController;
  final AuthController authController;
  final UserController userController;

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
      home: FutureBuilder<bool>(
        future: initializeSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == true) {
            return HomePage(
              authController: authController,
              activeWorkoutController: activeWorkoutController,
              workoutHistoryController: workoutHistoryController,
              exerciseDefinitionController: exerciseDefinitionController,
              userController: userController,
            );
          }
          return LoginPage(
            userController: userController,
            authController: authController,
            exerciseDefinitionController: exerciseDefinitionController,
            activeWorkoutController: activeWorkoutController,
            workoutHistoryController: workoutHistoryController,
          );
        },
      ),
      // home: HomePage(activeWorkoutController : activeWorkoutController, workoutHistoryController: workoutHistoryController, exerciseController: exerciseController,),
    );
  }

  Future<bool> initializeSession() async {
    final bool isLoggedIn = await authController.checkSession();

    if (!isLoggedIn) {
      return false;
    }
    await exerciseDefinitionController.getAllExercises();
    await userController.getUserInfo();
    return true;
  }
}
