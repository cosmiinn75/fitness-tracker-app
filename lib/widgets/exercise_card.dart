import 'package:fitness_mvp/data/model/exercise_set_draft.dart';
import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/widgets/workout_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseCard extends StatefulWidget {
  ExerciseCard({super.key, required this.workoutExerciseDraft});

  final WorkoutExerciseDraft workoutExerciseDraft;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: Dimensions.calculateWidth(20, context),
        right: Dimensions.calculateWidth(20, context),
      ),
      margin: EdgeInsets.only(bottom: Dimensions.calculateHeight(5, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.calculateHeight(20, context),top: Dimensions.calculateHeight(30, context)),
            child: Text(widget.workoutExerciseDraft.exerciseDefinition.name, style: TextStyle(
              fontSize: Dimensions.calculateHeight(30, context),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold
            ),),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Dimensions.calculateWidth(35, context),
                child: Text(
                  textAlign: TextAlign.center,
                  "Set",
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(20, context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              SizedBox(
                width: Dimensions.calculateWidth(80, context),
                child: Text(
                  "Weight",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(20, context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              SizedBox(
                width: Dimensions.calculateWidth(80, context),
                child: Text(
                  textAlign: TextAlign.center,
                  "Reps",
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(20, context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              SizedBox(
                width: Dimensions.calculateWidth(80, context),
                child: Text(
                  textAlign: TextAlign.center,
                  "RIR",
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(20, context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.workoutExerciseDraft.sets.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  top: Dimensions.calculateHeight(15, context),
                ),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Dimensions.calculateWidth(35, context),
                      height: Dimensions.calculateHeight(35, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(15, context),
                        ),
                        color: AppColors.accent,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: Dimensions.calculateHeight(18, context),
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.calculateWidth(80, context),
                      child: WorkoutTextField(
                        hintText: "kg",
                        inputFormatters: [
                          TextInputFormatter.withFunction(((
                            oldValue,
                            newValue,
                          ) {
                            if (newValue.text.isEmpty) {
                              return newValue;
                            }
                            final value = double.tryParse(newValue.text);
                            if (value != null && value >= 0) {
                              return newValue;
                            }

                            return TextEditingValue.empty;
                          })),
                        ],
                        valueChanged: (value) {
                          final weight = double.tryParse(value);
                          widget.workoutExerciseDraft.sets[index].weight = weight;
                        },
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.calculateWidth(80, context),
                      child: WorkoutTextField(

                        hintText: "10",
                        inputFormatters: [
                          TextInputFormatter.withFunction(((
                            oldValue,
                            newValue,
                          ) {
                            if (newValue.text.isEmpty) {
                              return newValue;
                            }
                            final value = int.tryParse(newValue.text);
                            if (value != null && value > 0 && value < 101) {
                              return newValue;
                            }
                            return TextEditingValue(text: "100", selection: TextSelection.collapsed(offset: 3),);
                          })),
                        ],
                        valueChanged: (value) {
                          final reps = int.tryParse(value);
                          widget.workoutExerciseDraft.sets[index].reps = reps;
                        },
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.calculateWidth(80, context),
                      child: WorkoutTextField(

                        hintText: "1",
                        inputFormatters: [
                          TextInputFormatter.withFunction(((
                            oldValue,
                            newValue,
                          ) {
                            if (newValue.text.isEmpty) {
                              return newValue;
                            }

                            final value = int.tryParse(newValue.text);

                            if (value != null && value >= 0 && value <= 5) {
                              return newValue;
                            }

                            return TextEditingValue(text: "5", selection: TextSelection.collapsed(offset: 1),);
                          })),
                        ],
                        valueChanged: (value) {
                          final rir = int.tryParse(value);
                          widget.workoutExerciseDraft.sets[index].rir = rir;
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: Dimensions.calculateHeight(30, context),),

          GestureDetector(

            onTap: (){

              setState(() {
                widget.workoutExerciseDraft.addSet(ExerciseSetDraft(setNumber: widget.workoutExerciseDraft.sets.length+1));
              });
            },

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
                color: AppColors.accent,
              ),
              child: Center(
                child: Text(
                  "+ Add Set",
                  style: TextStyle(
                    fontSize: Dimensions.calculateHeight(20, context),
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
