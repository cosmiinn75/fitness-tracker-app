import 'package:fitness_mvp/data/controller/active_workout_controller.dart';
import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/widgets/exercise_card.dart';
import 'package:flutter/material.dart';

import '../../data/model/exercise_definition.dart';
import '../../data/model/workout_draft.dart';
import '../../helper/dimensions.dart';
import 'add_exercises_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key , required this.activeWorkoutController});

  final ActiveWorkoutController activeWorkoutController;


  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late final WorkoutDraft workout;

  bool isFinishedPressed = false;
  bool isExitPressed = false;
  late final TextEditingController workoutNameController;

  @override
  void initState() {
    super.initState();


    workout =
    widget.activeWorkoutController.activeWorkout!;

    workoutNameController = TextEditingController(
        text:workout.workoutName
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    workoutNameController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    final List<WorkoutExerciseDraft> exercises =
        workout.exercises;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: Dimensions.calculateHeight(25, context),
          ),

          itemCount: exercises.length + 2,

          itemBuilder: (context, index) {

            // HEADER
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.calculateWidth(20, context),
                  right: Dimensions.calculateWidth(20, context),
                  top: Dimensions.calculateHeight(25, context),
                  bottom: Dimensions.calculateHeight(20, context),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WORKOUT",
                      style: TextStyle(
                        color: const Color(0xFF8A84FF),
                        fontSize: Dimensions.calculateHeight(13, context),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.calculateHeight(8, context),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: workoutNameController,
                            onChanged: (value){
                                widget.activeWorkoutController.updateWorkoutName(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              hintText: "Workout name",
                              hintStyle: TextStyle(
                                color: Colors.white.withValues(alpha: 0.35),
                              ),
                            ),
                            style: TextStyle(
                              fontSize:
                              Dimensions.calculateHeight(28, context),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                            Dimensions.calculateWidth(12, context),
                            vertical:
                            Dimensions.calculateHeight(7, context),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D1F6E),
                            borderRadius: BorderRadius.circular(
                              Dimensions.calculateHeight(15, context),
                            ),
                            border: Border.all(
                              color: const Color(0xFF34368A),
                            ),
                          ),
                          child: Text(
                            "${exercises.length} ${exercises.length == 1 ? "exercise" : "exercises"}",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize:
                              Dimensions.calculateHeight(13, context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: Dimensions.calculateHeight(7, context),
                    ),

                    Text(
                      "Track your sets, weight, reps and RIR",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: Dimensions.calculateHeight(15, context),
                      ),
                    ),
                  ],
                ),
              );
            }

            // ADD EXERCISES
            if (index == exercises.length + 1) {
              return Column(
                children: [

                  // EMPTY STATE
                  if (exercises.isEmpty)
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: Dimensions.calculateWidth(20, context),
                        right: Dimensions.calculateWidth(20, context),
                        bottom: Dimensions.calculateHeight(20, context),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical:
                        Dimensions.calculateHeight(35, context),
                        horizontal:
                        Dimensions.calculateWidth(20, context),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1F6E),
                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(20, context),
                        ),
                        border: Border.all(
                          color: const Color(0xFF34368A),
                        ),
                      ),

                      child: Column(
                        children: [
                          Container(
                            width: Dimensions.calculateWidth(55, context),
                            height:
                            Dimensions.calculateHeight(55, context),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF)
                                  .withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.fitness_center,
                              color: const Color(0xFF8A84FF),
                              size:
                              Dimensions.calculateHeight(26, context),
                            ),
                          ),

                          SizedBox(
                            height:
                            Dimensions.calculateHeight(15, context),
                          ),

                          Text(
                            "No exercises yet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              Dimensions.calculateHeight(20, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height:
                            Dimensions.calculateHeight(7, context),
                          ),

                          Text(
                            "Add your first exercise to start building your workout.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                              Colors.white.withValues(alpha: 0.45),
                              fontSize:
                              Dimensions.calculateHeight(14, context),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                  GestureDetector(
                    onTap: () async {
                      final Set<int> unavailableExercises = exercises.map((e)=> e.exerciseDefinition.id).toSet();
                      final List<ExerciseDefinition>? newExercises =
                      await Navigator.push<List<ExerciseDefinition>>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          AddExercisesPage(unavailableExercises: unavailableExercises ),
                        ),
                      );

                      if (newExercises != null && newExercises.isNotEmpty) {
                        setState(() {
                          widget.activeWorkoutController.addExercises(newExercises);
                        });
                      }
                    },

                    child: Container(
                      height:
                      Dimensions.calculateHeight(52, context),
                      width: double.maxFinite,

                      margin: EdgeInsets.symmetric(
                        horizontal:
                        Dimensions.calculateWidth(20, context),
                        vertical: Dimensions.calculateHeight(10, context)
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),

                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(17, context),
                        ),

                        border: Border.all(
                          color: const Color(0xFF8A84FF),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF)
                                .withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size:
                            Dimensions.calculateHeight(24, context),
                          ),

                          SizedBox(
                            width:
                            Dimensions.calculateWidth(7, context),
                          ),

                          Text(
                            "Add Exercises",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              Dimensions.calculateHeight(17, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }


            return Dismissible(
              direction: DismissDirection.endToStart,
              key: ObjectKey(exercises[index-1]),
              onDismissed: (direction) {
                setState(() {
                widget.activeWorkoutController.removeExercise(index-1);
                });
              },

              background: Container(
                margin: EdgeInsets.only(
                  bottom: Dimensions.calculateHeight(8, context),
                ),

                padding: EdgeInsets.only(
                  right: Dimensions.calculateWidth(18, context),
                ),

                alignment: Alignment.centerRight,

                decoration: BoxDecoration(
                  color: const Color(0xFFB83A4B),

                  borderRadius: BorderRadius.circular(
                    Dimensions.calculateHeight(14, context),
                  ),
                ),

                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                  size: Dimensions.calculateHeight(24, context),
                ),
              ),
              child: ExerciseCard(
                workoutExerciseDraft: exercises[index - 1], activeWorkoutController: widget.activeWorkoutController,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(
            left: Dimensions.calculateWidth(20, context),
            right: Dimensions.calculateWidth(20, context),
            top: Dimensions.calculateHeight(12, context),
            bottom: Dimensions.calculateHeight(12, context),
          ),

          decoration: BoxDecoration(
            color: AppColors.background,

            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // FINISH WORKOUT
              GestureDetector(
                onTapDown: (_) {
                  if (exercises.isNotEmpty) {
                    setState(() {
                      isFinishedPressed = true;
                    });
                  }
                },

                onTapUp: (_) {
                  if (exercises.isNotEmpty) {
                    setState(() {
                      isFinishedPressed = false;
                    });
                  }
                },

                onTapCancel: () {
                  setState(() {
                    isFinishedPressed = false;
                  });
                },

                onTap:  () {
                    final error = widget.activeWorkoutController.finishWorkout();
                    if(error != null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                      return;
                    }
                    Navigator.pop(context);
                },

                child: AnimatedScale(
                  duration: const Duration(milliseconds: 120),
                  scale: isFinishedPressed ? 0.97 : 1,

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),

                    width: double.maxFinite,
                    height: Dimensions.calculateHeight(52, context),

                    decoration: BoxDecoration(
                      color: exercises.isEmpty
                          ? const Color(0xFF1D1F6E)
                          : isFinishedPressed
                          ? const Color(0xFF188A5A)
                          : const Color(0xFF22A06B),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(16, context),
                      ),

                      border: Border.all(
                        color: exercises.isEmpty
                            ? const Color(0xFF34368A)
                            : const Color(0xFF35C98B),
                      ),

                      boxShadow: exercises.isNotEmpty
                          ? [
                        BoxShadow(
                          color: const Color(0xFF22A06B)
                              .withValues(alpha: 0.22),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                          : [],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: Dimensions.calculateHeight(23, context),
                          color: exercises.isNotEmpty
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.35),
                        ),

                        SizedBox(
                          width: Dimensions.calculateWidth(8, context),
                        ),

                        Text(
                          "Finish Workout",
                          style: TextStyle(
                            color: exercises.isNotEmpty
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.35),
                            fontSize:
                            Dimensions.calculateHeight(17, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(10, context),
              ),

              // CANCEL WORKOUT
              GestureDetector(
                onTapDown: (_) {
                    setState(() {
                      isExitPressed = true;
                    });

                },

                onTapUp: (_) {
                    setState(() {
                      isExitPressed = false;
                    });
                },

                onTapCancel: () {
                  setState(() {
                    isExitPressed = false;
                  });
                },

                onTap: () {
                  widget.activeWorkoutController.deleteActiveWorkout();

                  Navigator.pop(context);
                },

                child: AnimatedScale(
                  duration: const Duration(milliseconds: 120),
                  scale: isExitPressed ? 0.97 : 1,

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),

                    width: double.maxFinite,
                    height: Dimensions.calculateHeight(46, context),

                    decoration: BoxDecoration(
                      color: isExitPressed
                          ? const Color(0xFF962F3D)
                          : const Color(0xFFB83A4B)
                          .withValues(alpha: 0.10),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(15, context),
                      ),

                      border: Border.all(
                        color: const Color(0xFFD65A68)
                            .withValues(alpha: 0.65),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          size: Dimensions.calculateHeight(20, context),
                          color: isExitPressed
                              ? Colors.white
                              : const Color(0xFFE87986),
                        ),

                        SizedBox(
                          width: Dimensions.calculateWidth(7, context),
                        ),

                        Text(
                          "Cancel Workout",
                          style: TextStyle(
                            color: isExitPressed
                                ? Colors.white
                                : const Color(0xFFE87986),
                            fontSize:
                            Dimensions.calculateHeight(15, context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}