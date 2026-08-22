import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/auth_controller.dart';

import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/controller/user_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/pages/home/main_page_body.dart';
import 'package:fitness_mvp/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({
    super.key,
    required this.authController,
    required this.userController,
    required this.activeWorkoutController,
    required this.exerciseDefinitionController,
    required this.workoutHistoryController
  });

  ActiveWorkoutController activeWorkoutController;
  ExerciseDefinitionController exerciseDefinitionController;
  UserController userController;
  AuthController authController;
  WorkoutHistoryController workoutHistoryController;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.calculateWidth(20, context),
                right: Dimensions.calculateWidth(20, context),
                top: Dimensions.calculateHeight(18, context),
                bottom: Dimensions.calculateHeight(12, context),
              ),

              child: Row(
                children: [
                  // TITLE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FITNESS WORLD",
                          style: TextStyle(
                            color: const Color(0xFF8A84FF),
                            fontSize: Dimensions.calculateHeight(12, context),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),

                        SizedBox(
                          height: Dimensions.calculateHeight(5, context),
                        ),

                        Text(
                          "Train smarter.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(25, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // PROFILE
                  GestureDetector(
                    onTap: () async {

                      if(widget.userController.userInfo == null){
                        await widget.userController.getUserInfo();
                      }

                      if(!mounted){
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            userController: widget.userController,
                            authController: widget.authController,
                            exerciseDefinitionController:
                                widget.exerciseDefinitionController,
                            workoutHistoryController:
                                widget.workoutHistoryController,
                            activeWorkoutController:
                                widget.activeWorkoutController,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: Dimensions.calculateWidth(46, context),
                      height: Dimensions.calculateHeight(46, context),

                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1F6E),

                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(15, context),
                        ),

                        border: Border.all(color: const Color(0xFF34368A)),
                      ),

                      child: Icon(
                        Icons.person_rounded,
                        color: const Color(0xFFAAA6FF),
                        size: Dimensions.calculateHeight(24, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // SEPARATOR
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.calculateWidth(20, context),
              ),
              child: Divider(
                color: Colors.white.withValues(alpha: 0.07),
                height: 1,
              ),
            ),

            // PAGE CONTENT
            Expanded(
              child: MainPageBody(
                activeWorkoutController: widget.activeWorkoutController,
                userController: widget.userController,
                exerciseDefinitionController:
                    widget.exerciseDefinitionController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
