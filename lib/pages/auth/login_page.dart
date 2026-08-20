import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/controller/auth_controller.dart';
import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/pages/auth/signup_page.dart';
import 'package:fitness_mvp/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.authController,
    required this.exerciseDefinitionController,
    required this.activeWorkoutController,
    required this.workoutHistoryController,
  });

  final AuthController authController;
  final WorkoutHistoryController workoutHistoryController;
  final ActiveWorkoutController activeWorkoutController;
  final ExerciseDefinitionController exerciseDefinitionController;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Dimensions.calculateHeight(50, context),
              ),
              width: Dimensions.calculateWidth(75, context),
              height: Dimensions.calculateHeight(75, context),

              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.15),

                shape: BoxShape.circle,

                border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.5),
                ),
              ),

              child: Icon(
                Icons.fitness_center_rounded,
                color: const Color(0xFF8A84FF),
                size: Dimensions.calculateHeight(34, context),
              ),
            ),
            SizedBox(height: Dimensions.calculateHeight(20, context)),
            Text(
              "Welcome back",
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.calculateHeight(30, context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimensions.calculateHeight(20, context)),
            Text(
              "Sign in to continue your fitness journey",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.calculateHeight(20, context),
              ),
            ),
            SizedBox(height: Dimensions.calculateHeight(40, context)),
            Container(
              margin: EdgeInsetsGeometry.symmetric(
                horizontal: Dimensions.calculateWidth(30, context),
              ),

              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.calculateWidth(20, context),
                vertical: Dimensions.calculateHeight(28, context),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF25277A),
                borderRadius: BorderRadius.circular(
                  Dimensions.calculateHeight(20, context),
                ),
                border: Border.all(color: const Color(0xFF8A84FF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(24, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.calculateHeight(5, context),
                        ),
                        _textField(
                          hintText: "your_username",
                          obscureText: false,
                          controller: usernameController,
                          isFocused: isUsernameFocused,
                          onFocusChange: (value) {
                            setState(() {
                              isUsernameFocused = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: Dimensions.calculateHeight(20, context),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(24, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.calculateHeight(5, context),
                        ),
                        _passwordTextField(
                          hintText: "your_password",
                          obscureText: obscurePassword,
                          isPasswordField: true,
                          controller: passwordController,
                          isFocused: isPasswordFocused,
                          onFocusChange: (value) {
                            isPasswordFocused = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.calculateHeight(40, context)),
                  GestureDetector(
                    onTap: () async {



                      final String username = usernameController.text.trim();

                      final String password = passwordController.text;

                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please complete all fields."),
                          ),
                        );
                        return;
                      }

                      if (!isValidUsername(username)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Username must be between 3-30 characters and contain only letters, numbers and ._",
                            ),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      String? error = await widget.authController.login(
                        username,
                        password,
                      );

                      if (!mounted) return;

                      setState(() {
                        isLoading = false;
                      });

                      if (error == null) {
                       await widget.exerciseDefinitionController.getAllExercises();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              activeWorkoutController:
                                  widget.activeWorkoutController,
                              workoutHistoryController:
                                  widget.workoutHistoryController,
                              exerciseDefinitionController: widget.exerciseDefinitionController,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      }
                    },

                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.calculateHeight(50, context),

                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(15, context),
                        ),
                      ),

                      child: Center(
                        child: isLoading ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          )
                        ): Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(17, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.calculateHeight(20, context)),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: Dimensions.calculateHeight(15, context),
                        ),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Sign up here",
                            style: TextStyle(
                              color: AppColors.accent.withValues(alpha: 0.65),
                              fontSize: Dimensions.calculateHeight(15, context),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage(
                                      authController: widget.authController,
                                      activeWorkoutController:
                                          widget.activeWorkoutController,
                                      workoutHistoryController:
                                          widget.workoutHistoryController,
                                      exerciseDefinitionController:
                                          widget.exerciseDefinitionController,
                                    ),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String hintText,
    required TextEditingController controller,
    bool isPasswordField = false,
    required bool obscureText,
    required bool isFocused,
    required ValueChanged<bool> onFocusChange,
  }) {
    return Focus(
      onFocusChange: onFocusChange,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),

        width: double.maxFinite,
        height: Dimensions.calculateHeight(48, context),

        decoration: BoxDecoration(
          color: isFocused ? const Color(0xFF25277A) : const Color(0xFF181A61),

          borderRadius: BorderRadius.circular(
            Dimensions.calculateHeight(12, context),
          ),

          border: Border.all(
            color: isFocused
                ? const Color(0xFF8A84FF)
                : const Color(0xFF34368A),
            width: isFocused ? 1.5 : 1,
          ),

          boxShadow: isFocused
              ? [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.18),
              blurRadius: 8,
            ),
          ]
              : [],
        ),

        child:TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.calculateHeight(15, context),
            ),

            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: isPasswordField ? IconButton(
                icon:  Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                color: Colors.white54,
                onPressed: (){
                  setState(() {
                    this.obscurePassword = !this.obscurePassword;
                  });
                },) : null,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.28),
                fontSize: Dimensions.calculateHeight(14, context),
              ),

              contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.calculateWidth(15, context),
              ),

              border: InputBorder.none,
            ),
          ),

      ),
    );
  }


  Widget _passwordTextField({
    required String hintText,
    required TextEditingController controller,
    bool isPasswordField = false,
    required bool obscureText,
    required bool isFocused,
    required ValueChanged<bool> onFocusChange,
  }) {
    return Focus(
      onFocusChange: onFocusChange,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),

        width: double.maxFinite,
        height: Dimensions.calculateHeight(48, context),

        decoration: BoxDecoration(
          color: isFocused ? const Color(0xFF25277A) : const Color(0xFF181A61),

          borderRadius: BorderRadius.circular(
            Dimensions.calculateHeight(12, context),
          ),

          border: Border.all(
            color: isFocused
                ? const Color(0xFF8A84FF)
                : const Color(0xFF34368A),
            width: isFocused ? 1.5 : 1,
          ),

          boxShadow: isFocused
              ? [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.18),
              blurRadius: 8,
            ),
          ]
              : [],
        ),

        child:TextField(
          controller: controller,
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.calculateHeight(15, context),
          ),

          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isPasswordField ? IconButton(
              icon:  Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
              color: Colors.white54,
              onPressed: (){
                setState(() {
                  this.obscurePassword = !this.obscurePassword;
                });
              },) : null,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.28),
              fontSize: Dimensions.calculateHeight(14, context),
            ),

            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.calculateWidth(15, context),
            ),

            border: InputBorder.none,
          ),
        ),

      ),
    );
  }

  bool isValidUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

    return username.length >= 3 &&
        username.length <= 30 &&
        usernameRegex.hasMatch(username);
  }
}
