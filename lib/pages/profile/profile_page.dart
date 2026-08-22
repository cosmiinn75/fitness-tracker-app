import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/auth_controller.dart';
import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/controller/user_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      {super.key, required this.authController, required this.userController, required this.workoutHistoryController, required this.activeWorkoutController, required this.exerciseDefinitionController});

  AuthController authController;
  UserController userController;
  ExerciseDefinitionController exerciseDefinitionController;
  ActiveWorkoutController activeWorkoutController;
  WorkoutHistoryController workoutHistoryController;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //Header
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.calculateWidth(20, context),
                right: Dimensions.calculateWidth(20, context),
                top: Dimensions.calculateHeight(18, context),
                bottom: Dimensions.calculateHeight(12, context),
              ),
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PROFILE",
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
                          "See your personal info.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(25, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                        Icons.clear,
                        color: const Color(0xFFAAA6FF),
                        size: Dimensions.calculateHeight(24, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.calculateHeight(5, context)),
            Divider(color: Colors.white.withValues(alpha: 0.07)),
            SizedBox(height: Dimensions.calculateHeight(10, context)),

            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              padding: EdgeInsets.only(
                top: Dimensions.calculateHeight(10, context),
                bottom: Dimensions.calculateHeight(10, context),
                left: Dimensions.calculateWidth(10, context),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1F6E),

                borderRadius: BorderRadius.circular(
                  Dimensions.calculateHeight(22, context),
                ),

                border: Border.all(color: const Color(0xFF34368A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name
                  Container(
                    margin: EdgeInsetsGeometry.symmetric(
                      vertical: Dimensions.calculateHeight(10, context),
                      horizontal: Dimensions.calculateWidth(20, context),
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.calculateHeight(10, context),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(17, context),
                      ),

                      border: Border.all(color: const Color(0xFF8A84FF)),

                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF6C63FF,
                          ).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
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
                            Icons.person_2,
                            color: const Color(0xFFAAA6FF),
                            size: Dimensions.calculateHeight(24, context),
                          ),
                        ),
                        SizedBox(width: Dimensions.calculateWidth(15, context)),
                        Expanded(
                          child: Text(
                            widget.userController.userInfo!.username,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.calculateHeight(20, context),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Email
                  Container(
                    margin: EdgeInsetsGeometry.symmetric(
                      vertical: Dimensions.calculateHeight(10, context),
                      horizontal: Dimensions.calculateWidth(20, context),
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.calculateHeight(10, context),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(17, context),
                      ),

                      border: Border.all(color: const Color(0xFF8A84FF)),

                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF6C63FF,
                          ).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
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
                            Icons.mail,
                            color: const Color(0xFFAAA6FF),
                            size: Dimensions.calculateHeight(24, context),
                          ),
                        ),
                        SizedBox(width: Dimensions.calculateWidth(15, context)),
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            widget.userController.userInfo!.email,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: Dimensions.calculateHeight(20, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Total workouts
                  Container(
                    margin: EdgeInsetsGeometry.symmetric(
                      vertical: Dimensions.calculateHeight(10, context),
                      horizontal: Dimensions.calculateWidth(20, context),
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.calculateHeight(10, context),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(17, context),
                      ),

                      border: Border.all(color: const Color(0xFF8A84FF)),

                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF6C63FF,
                          ).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
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
                            Icons.fitness_center_rounded,
                            color: const Color(0xFFAAA6FF),
                            size: Dimensions.calculateHeight(24, context),
                          ),
                        ),
                        SizedBox(width: Dimensions.calculateWidth(15, context)),
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            "${widget.userController.userInfo!
                                .totalWorkouts} total workout${widget.userController.userInfo!.totalWorkouts != 1 ? "s" : ""}" ,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: Dimensions.calculateHeight(20, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Logout
            GestureDetector(
              onTap: () async {
              await widget.authController.logout();

                widget.userController.userInfo = null;
                widget.activeWorkoutController.deleteActiveWorkout();
                widget.workoutHistoryController.clearHistory();
                widget.exerciseDefinitionController.clearExercises();

                if (!mounted) {
                  return;
                }
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(
                            userController: widget.userController,
                            authController: widget.authController,
                            exerciseDefinitionController: widget
                                .exerciseDefinitionController,
                            activeWorkoutController: widget
                                .activeWorkoutController,
                            workoutHistoryController: widget.workoutHistoryController)),
                    (route)=> false);
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.calculateHeight(30, context),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                height: Dimensions.calculateHeight(50, context),

                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(
                    Dimensions.calculateHeight(15, context),
                  ),
                ),

                child: Center(
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.calculateHeight(17, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
