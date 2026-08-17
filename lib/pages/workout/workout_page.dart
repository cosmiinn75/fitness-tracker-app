import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/widgets/exercise_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/exercise_definition.dart';
import '../../data/model/exercise_set_draft.dart';
import '../../helper/dimensions.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  List<WorkoutExerciseDraft> exercises = [];

  @override
  void initState() {
    
    super.initState();
    exercises.add(
      WorkoutExerciseDraft(
        exerciseNumber: 1,
        exerciseDefinition: ExerciseDefinition(
          id: 1,
          name: "Bench Press",
          muscleGroup: "Chest",
        ),
        sets: [
          ExerciseSetDraft(setNumber: 1),
          ExerciseSetDraft(setNumber: 2),
        ],
      ),

    );
    exercises.add(
      WorkoutExerciseDraft(
        exerciseNumber: 1,
        exerciseDefinition: ExerciseDefinition(
          id: 1,
          name: "Bench Press",
          muscleGroup: "Chest",
        ),
        sets: [
          ExerciseSetDraft(setNumber: 1),
          ExerciseSetDraft(setNumber: 2),
        ],
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView.builder(
          itemCount: exercises.length + 2,
          itemBuilder: (context, index) {


            if (index == 0) {
              return Container(
                margin: EdgeInsets.only(
                  top: Dimensions.calculateHeight(30, context),
                  bottom: Dimensions.calculateHeight(20, context),
                ),
                padding: EdgeInsets.only(
                  left: Dimensions.calculateWidth(20, context),
                ),
                child: Text(
                  "Afternoon workout",
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(32, context),
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }


            if (index == exercises.length + 1) {
              return Padding(
                padding: EdgeInsets.all(
                  Dimensions.calculateWidth(20, context),
                ),
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.calculateHeight(35, context),

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.surface.withValues(alpha: 0.8),
                            offset: Offset(0, 5),
                            blurRadius: 3,
                            spreadRadius: 3

                        )
                      ],
                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(15, context),

                      ),
                      color: AppColors.textPrimary,
                    ),
                    child: Center(
                      child: Text(
                        "+ Add Exercises",
                        style: TextStyle(
                          fontSize: Dimensions.calculateHeight(20, context),
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),

              );
            }


            return ExerciseCard(
              workoutExerciseDraft: exercises[index - 1],
            );
          },
        ),
      ),
    );
  }
}
