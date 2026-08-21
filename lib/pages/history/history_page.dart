import 'package:fitness_mvp/data/DTO/workout_response.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/widgets/workout_history_card.dart';
import 'package:flutter/material.dart';

import '../../helper/dimensions.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.workoutHistoryController});

  final WorkoutHistoryController workoutHistoryController;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadContent();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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
                          "WORKOUT HISTORY",
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
                          "See all your progress in one place.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(20, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: Dimensions.calculateHeight(20, context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.workoutHistoryController.workouts.isEmpty
                  ? Center(
                      child: Text(
                        "No workouts completed yet.",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: Dimensions.calculateHeight(15, context),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.calculateWidth(20, context),
                      ),
                      controller: scrollController,
                      itemCount:
                          widget.workoutHistoryController.workouts.length +
                          (widget.workoutHistoryController.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index ==
                            widget.workoutHistoryController.workouts.length) {
                          return Padding(
                            padding: EdgeInsets.all(
                              Dimensions.calculateHeight(20, context),
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        final workout = widget.workoutHistoryController.workouts[index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key: ValueKey(
                            workout.id,
                          ),
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
                          confirmDismiss: (direction) async {
                            bool? shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  backgroundColor: AppColors.background,
                                  title: const Text(
                                    "Delete workout?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete workout",
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext, false);
                                      },
                                      child: const Text("Cancel", style: TextStyle(color:  Color(0xFF8A84FF)),),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext, true);
                                      },
                                      child: const Text("Delete", style: TextStyle(color:  Color(0xFF8A84FF)),),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (shouldDelete != true) {
                              return false;
                            }
                            final error = await widget.workoutHistoryController
                                .deleteWorkout(
                                  workout
                                      .id,
                                );


                            return error == null;
                          },
                          onDismissed: (direction){
                            setState(() {

                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              showWorkoutDetails(
                                context,
                                widget.workoutHistoryController.workouts[index],
                              );
                            },
                            child: WorkoutHistoryCard(
                              workout: widget
                                  .workoutHistoryController
                                  .workouts[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showWorkoutDetails(BuildContext context, WorkoutResponse workout) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF1D1F6E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(
              Dimensions.calculateHeight(20, context),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            padding: EdgeInsets.all(Dimensions.calculateWidth(20, context)),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        workout.workoutName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.calculateHeight(12, context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.calculateHeight(5, context)),
                Text(
                  "${workout.date.day}/${workout.date.month}/${workout.date.year}",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: Dimensions.calculateHeight(13, context),
                  ),
                ),
                SizedBox(height: Dimensions.calculateHeight(18, context)),

                Divider(color: Colors.white.withValues(alpha: 0.08)),

                SizedBox(height: Dimensions.calculateHeight(10, context)),

                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: workout.exercises.length,
                    itemBuilder: (context, exerciseIndex) {
                      final exercise = workout.exercises[exerciseIndex];

                      return Padding(
                        padding: EdgeInsetsGeometry.only(
                          bottom: Dimensions.calculateHeight(20, context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise.exerciseName,
                              style: TextStyle(
                                color: const Color(0xFFAAA6FF),
                                fontSize: Dimensions.calculateHeight(
                                  17,
                                  context,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.calculateHeight(10, context),
                            ),

                            //TABLE HEADER
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "SET",
                                    style: _labelStyle(context),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "KG",
                                    style: _labelStyle(context),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "REPS",
                                    style: _labelStyle(context),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "RIR",
                                    style: _labelStyle(context),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.calculateHeight(7, context),
                            ),

                            ...exercise.sets.map((set) {
                              return Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: Dimensions.calculateHeight(
                                    5,
                                    context,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${set.setNumber}",
                                        style: _valueStyle(context),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        set.weight?.toString() ?? "0",
                                        style: _valueStyle(context),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        set.reps?.toString() ?? "-",
                                        style: _valueStyle(context),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        set.rir?.toString() ?? "-",
                                        style: _valueStyle(context),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white.withValues(alpha: 0.4),
      fontSize: Dimensions.calculateHeight(11, context),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _valueStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: Dimensions.calculateHeight(14, context),
    );
  }

  Future<void> loadContent() async {
    setState(() {});

    await widget.workoutHistoryController.loadWorkouts();

    if (!mounted) return;

    setState(() {});
  }
}
