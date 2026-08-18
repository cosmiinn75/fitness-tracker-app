import 'package:fitness_mvp/data/model/exercise_set_draft.dart';
import 'package:fitness_mvp/data/model/workout_exercise_draft.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/widgets/workout_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.workoutExerciseDraft});

  final WorkoutExerciseDraft workoutExerciseDraft;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,

      margin: EdgeInsets.only(
        left: Dimensions.calculateWidth(20, context),
        right: Dimensions.calculateWidth(20, context),
        bottom: Dimensions.calculateHeight(18, context),
      ),

      padding: EdgeInsets.all(Dimensions.calculateWidth(16, context)),

      decoration: BoxDecoration(
        color: const Color(0xFF1D1F6E),

        borderRadius: BorderRadius.circular(
          Dimensions.calculateHeight(22, context),
        ),

        border: Border.all(color: const Color(0xFF34368A)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // EXERCISE HEADER
          Row(
            children: [
              Container(
                width: Dimensions.calculateWidth(42, context),
                height: Dimensions.calculateHeight(42, context),

                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.18),

                  borderRadius: BorderRadius.circular(
                    Dimensions.calculateHeight(13, context),
                  ),
                ),

                child: Icon(
                  Icons.fitness_center_rounded,
                  color: const Color(0xFF8A84FF),
                  size: Dimensions.calculateHeight(21, context),
                ),
              ),

              SizedBox(width: Dimensions.calculateWidth(12, context)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.workoutExerciseDraft.exerciseDefinition.name,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.calculateHeight(21, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: Dimensions.calculateHeight(3, context)),

                    Text(
                      widget
                          .workoutExerciseDraft
                          .exerciseDefinition
                          .muscleGroup,

                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: Dimensions.calculateHeight(14, context),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.calculateWidth(10, context),
                  vertical: Dimensions.calculateHeight(6, context),
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.15),

                  borderRadius: BorderRadius.circular(
                    Dimensions.calculateHeight(12, context),
                  ),
                ),

                child: Text(
                  "${widget.workoutExerciseDraft.sets.length} sets",

                  style: TextStyle(
                    color: const Color(0xFFAAA6FF),
                    fontSize: Dimensions.calculateHeight(12, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),


            ],
          ),

          SizedBox(height: Dimensions.calculateHeight(22, context)),

          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),

          SizedBox(height: Dimensions.calculateHeight(16, context)),

          // TABLE HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderText("SET", 35, context),

              _buildHeaderText("KG", 80, context),

              _buildHeaderText("REPS", 80, context),

              _buildHeaderText("RIR", 80, context),
            ],
          ),

          SizedBox(height: Dimensions.calculateHeight(10, context)),

          // SETS
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: widget.workoutExerciseDraft.sets.length,

            itemBuilder: (context, index) {
              final set = widget.workoutExerciseDraft.sets[index];

              return Dismissible(
                key: ObjectKey(set),

                direction: DismissDirection.endToStart,

                onDismissed: (direction) {
                  setState(() {
                    widget.workoutExerciseDraft.sets.removeAt(index);

                    for (
                      int i = index;
                      i < widget.workoutExerciseDraft.sets.length;
                      i++
                    ) {
                      widget.workoutExerciseDraft.sets[i].setNumber = i + 1;
                    }
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

                child: Container(
                  margin: EdgeInsets.only(
                    bottom: Dimensions.calculateHeight(8, context),
                  ),

                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.calculateHeight(5, context),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      // SET NUMBER
                      Container(
                        width: Dimensions.calculateWidth(35, context),

                        height: Dimensions.calculateHeight(35, context),

                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF6C63FF,
                          ).withValues(alpha: 0.18),

                          borderRadius: BorderRadius.circular(
                            Dimensions.calculateHeight(11, context),
                          ),

                          border: Border.all(
                            color: const Color(
                              0xFF6C63FF,
                            ).withValues(alpha: 0.35),
                          ),
                        ),

                        child: Text(
                          "${index + 1}",

                          style: TextStyle(
                            color: const Color(0xFFB9B6FF),
                            fontSize: Dimensions.calculateHeight(16, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // WEIGHT
                      SizedBox(
                        width: Dimensions.calculateWidth(80, context),

                        child: WorkoutTextField(
                          hintText: "kg",

                          inputFormatters: [
                            TextInputFormatter.withFunction((
                              oldValue,
                              newValue,
                            ) {

                             if(newValue.text.isEmpty){
                               return newValue;
                             }
                             final valid = RegExp(r'^\d*[.,]?\d*$').hasMatch(newValue.text);

                             return valid ? newValue : oldValue;

                            }),
                          ],

                          valueChanged: (value) {
                            final weight = double.tryParse(value.replaceAll(',', '.'));

                            widget.workoutExerciseDraft.sets[index].weight =
                                weight;
                          },
                        ),
                      ),

                      // REPS
                      SizedBox(
                        width: Dimensions.calculateWidth(80, context),

                        child: WorkoutTextField(
                          hintText: "10",

                          inputFormatters: [
                            TextInputFormatter.withFunction((
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

                              return oldValue;
                            }),
                          ],

                          valueChanged: (value) {
                            final reps = int.tryParse(value);

                            widget.workoutExerciseDraft.sets[index].reps = reps;
                          },
                        ),
                      ),

                      // RIR
                      SizedBox(
                        width: Dimensions.calculateWidth(80, context),

                        child: WorkoutTextField(
                          hintText: "1",

                          inputFormatters: [
                            TextInputFormatter.withFunction((
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

                              return oldValue;
                            }),
                          ],

                          valueChanged: (value) {
                            final rir = int.tryParse(value);

                            widget.workoutExerciseDraft.sets[index].rir = rir;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: Dimensions.calculateHeight(12, context)),

          // ADD SET BUTTON
          GestureDetector(
            onTap: () {
              setState(() {
                widget.workoutExerciseDraft.addSet(
                  ExerciseSetDraft(
                    setNumber: widget.workoutExerciseDraft.sets.length + 1,
                  ),
                );
              });
            },

            child: Container(
              width: double.maxFinite,

              height: Dimensions.calculateHeight(42, context),

              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.12),

                borderRadius: BorderRadius.circular(
                  Dimensions.calculateHeight(14, context),
                ),

                border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.45),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.add_rounded,
                    color: const Color(0xFFAAA6FF),
                    size: Dimensions.calculateHeight(21, context),
                  ),

                  SizedBox(width: Dimensions.calculateWidth(5, context)),

                  Text(
                    "Add Set",

                    style: TextStyle(
                      color: const Color(0xFFAAA6FF),
                      fontSize: Dimensions.calculateHeight(16, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text, double width, BuildContext context) {
    return SizedBox(
      width: Dimensions.calculateWidth(width, context),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: Dimensions.calculateHeight(12, context),
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}
