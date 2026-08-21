
import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/controller/workout_history_controller.dart';
import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/data/model/workout_draft.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:flutter/material.dart';

class ViewExercisesPage extends StatefulWidget {
  const ViewExercisesPage({super.key, required this.workoutHistoryController, required this.exerciseDefinitionController});

  final WorkoutHistoryController workoutHistoryController;
  final ExerciseDefinitionController exerciseDefinitionController;

  @override
  State<ViewExercisesPage> createState() => _ViewExercisesPageState();
}

class _ViewExercisesPageState extends State<ViewExercisesPage> {

  final List<String> muscleGroups = [
    "Chest",
    "Back",
    "Arms",
    "Shoulders",
    "Legs",
    "Core",
  ];

  String searchQuery = "";
  int? selectedMuscleGroup;

  @override
  Widget build(BuildContext context) {

    final List<ExerciseDefinition> filteredExercises =
    widget.exerciseDefinitionController.exercises.where((exercise) {

      final bool matchesSearch =
      exercise.exerciseName
          .toLowerCase()
          .contains(searchQuery.trim().toLowerCase());

      final bool matchesMuscleGroup =
          selectedMuscleGroup == null ||
              exercise.muscleGroup ==
                  muscleGroups[selectedMuscleGroup!].toUpperCase();

      return matchesSearch && matchesMuscleGroup;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [

            // HEADER + SEARCH + FILTERS
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                Dimensions.calculateWidth(20, context),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  SizedBox(
                    height:
                    Dimensions.calculateHeight(18, context),
                  ),

                  // TITLE
                  Text(
                    "EXERCISES",
                    style: TextStyle(
                      color: const Color(0xFF8A84FF),
                      fontSize:
                      Dimensions.calculateHeight(12, context),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(
                    height:
                    Dimensions.calculateHeight(5, context),
                  ),

                  Text(
                    "Browse and discover exercises.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                      Dimensions.calculateHeight(20, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height:
                    Dimensions.calculateHeight(22, context),
                  ),

                  // SEARCH
                  Container(
                    height:
                    Dimensions.calculateHeight(50, context),

                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1F6E),

                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(16, context),
                      ),

                      border: Border.all(
                        color: const Color(0xFF34368A),
                      ),
                    ),

                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },

                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                        Dimensions.calculateHeight(
                          15,
                          context,
                        ),
                      ),

                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.white
                              .withValues(alpha: 0.5),
                        ),

                        hintText: "Search exercises",

                        hintStyle: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.4),
                        ),

                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          vertical:
                          Dimensions.calculateHeight(
                            14,
                            context,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                    Dimensions.calculateHeight(22, context),
                  ),

                  // MUSCLE GROUP TITLE
                  Text(
                    "Muscle group",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                      Dimensions.calculateHeight(16, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height:
                    Dimensions.calculateHeight(12, context),
                  ),

                  // FILTERS
                  Wrap(
                    spacing:
                    Dimensions.calculateWidth(10, context),

                    runSpacing:
                    Dimensions.calculateHeight(10, context),

                    children:
                    List.generate(
                      muscleGroups.length,
                          (index) {

                        final bool selected =
                            selectedMuscleGroup == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMuscleGroup =
                              selected
                                  ? null
                                  : index;
                            });
                          },

                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 180,
                            ),

                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              Dimensions.calculateWidth(
                                16,
                                context,
                              ),

                              vertical:
                              Dimensions.calculateHeight(
                                9,
                                context,
                              ),
                            ),

                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(
                                0xFF6C63FF,
                              )
                                  : const Color(
                                0xFF1D1F6E,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                Dimensions.calculateHeight(
                                  20,
                                  context,
                                ),
                              ),

                              border: Border.all(
                                color: selected
                                    ? const Color(
                                  0xFF8A84FF,
                                )
                                    : const Color(
                                  0xFF34368A,
                                ),
                              ),
                            ),

                            child: Text(
                              muscleGroups[index],

                              style: TextStyle(
                                color: Colors.white,

                                fontSize:
                                Dimensions.calculateHeight(
                                  14,
                                  context,
                                ),

                                fontWeight: selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height:
              Dimensions.calculateHeight(25, context),
            ),

            // EXERCISES TITLE + COUNT
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                Dimensions.calculateWidth(20, context),
              ),

              child: Row(
                children: [

                  Text(
                    "Exercises",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                      Dimensions.calculateHeight(18, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "${filteredExercises.length}",
                    style: TextStyle(
                      color: Colors.white
                          .withValues(alpha: 0.4),

                      fontSize:
                      Dimensions.calculateHeight(13, context),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height:
              Dimensions.calculateHeight(12, context),
            ),

            // EXERCISES LIST
            Expanded(
              child: filteredExercises.isEmpty
                  ? Center(
                child: Text(
                  "No exercises found.",
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: 0.4),

                    fontSize:
                    Dimensions.calculateHeight(
                      15,
                      context,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.only(
                  left:
                  Dimensions.calculateWidth(
                    20,
                    context,
                  ),

                  right:
                  Dimensions.calculateWidth(
                    20,
                    context,
                  ),

                  bottom:
                  Dimensions.calculateHeight(
                    20,
                    context,
                  ),
                ),

                itemCount:
                filteredExercises.length,

                itemBuilder: (context, index) {

                  final ExerciseDefinition exercise =
                  filteredExercises[index];

                  return GestureDetector(

                    onTap: (){
                          showExerciseHistory(context, filteredExercises[index]);
                    },

                    child: Container(
                      margin: EdgeInsets.only(
                        bottom:
                        Dimensions.calculateHeight(
                          12,
                          context,
                        ),
                      ),

                      padding: EdgeInsets.all(
                        Dimensions.calculateWidth(
                          14,
                          context,
                        ),
                      ),

                      decoration: BoxDecoration(
                        color:
                        const Color(0xFF1D1F6E),

                        borderRadius:
                        BorderRadius.circular(
                          Dimensions.calculateHeight(
                            16,
                            context,
                          ),
                        ),

                        border: Border.all(
                          color:
                          const Color(0xFF34368A),
                        ),
                      ),

                      child: Row(
                        children: [

                          // ICON
                          Container(
                            width:
                            Dimensions.calculateWidth(
                              44,
                              context,
                            ),

                            height:
                            Dimensions.calculateHeight(
                              44,
                              context,
                            ),

                            decoration:
                            BoxDecoration(
                              color: const Color(
                                0xFF6C63FF,
                              ).withValues(
                                alpha: 0.15,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                Dimensions.calculateHeight(
                                  13,
                                  context,
                                ),
                              ),
                            ),

                            child: Icon(
                              Icons
                                  .fitness_center_rounded,

                              color:
                              const Color(0xFF8A84FF),

                              size:
                              Dimensions.calculateHeight(
                                21,
                                context,
                              ),
                            ),
                          ),

                          SizedBox(
                            width:
                            Dimensions.calculateWidth(
                              12,
                              context,
                            ),
                          ),

                          // EXERCISE INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  exercise.exerciseName,

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize:
                                    Dimensions.calculateHeight(
                                      16,
                                      context,
                                    ),

                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                SizedBox(
                                  height:
                                  Dimensions.calculateHeight(
                                    3,
                                    context,
                                  ),
                                ),

                                Text(
                                  exercise.muscleGroup,

                                  style: TextStyle(
                                    color: Colors.white
                                        .withValues(
                                      alpha: 0.4,
                                    ),

                                    fontSize:
                                    Dimensions.calculateHeight(
                                      13,
                                      context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ARROW
                          Icon(
                            Icons
                                .arrow_forward_ios_rounded,

                            size:
                            Dimensions.calculateHeight(
                              15,
                              context,
                            ),

                            color: Colors.white
                                .withValues(
                              alpha: 0.25,
                            ),
                          ),
                        ],
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

  void showExerciseHistory(
      BuildContext context,
      ExerciseDefinition exercise,
      ) {
    final workouts = widget.workoutHistoryController
        .getWorkoutsForExercise(exercise.exerciseName);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF1D1F6E),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: Container(
            padding: EdgeInsets.all(
              Dimensions.calculateWidth(20, context),
            ),

            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.7,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        exercise.exerciseName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          Dimensions.calculateHeight(21, context),
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
                        color:
                        Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(4, context),
                ),

                Text(
                  exercise.muscleGroup,
                  style: TextStyle(
                    color: const Color(0xFFAAA6FF),
                    fontSize:
                    Dimensions.calculateHeight(14, context),
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(18, context),
                ),

                Divider(
                  color: Colors.white.withValues(alpha: 0.08),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(10, context),
                ),

                if (workouts.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                      Dimensions.calculateHeight(30, context),
                    ),

                    child: Center(
                      child: Text(
                        "No history for this exercise yet.",
                        style: TextStyle(
                          color:
                          Colors.white.withValues(alpha: 0.45),
                        ),
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workouts.length,

                      itemBuilder: (context, index) {
                        final workout = workouts[index];

                        final workoutExercise =
                        workout.exercises.firstWhere(
                              (e) =>
                          e.exerciseName ==
                              exercise.exerciseName,
                        );

                        return Container(
                          margin: EdgeInsets.only(
                            bottom:
                            Dimensions.calculateHeight(
                              16,
                              context,
                            ),
                          ),

                          padding: EdgeInsets.all(
                            Dimensions.calculateWidth(
                              14,
                              context,
                            ),
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFF181A61),

                            borderRadius:
                            BorderRadius.circular(14),

                            border: Border.all(
                              color: const Color(0xFF34368A),
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [
                              Text(
                                "${workout.date.day}/${workout.date.month}/${workout.date.year}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  Dimensions.calculateHeight(
                                    15,
                                    context,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height:
                                Dimensions.calculateHeight(
                                  12,
                                  context,
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "SET",
                                      style: _historyLabelStyle(
                                        context,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "KG",
                                      style: _historyLabelStyle(
                                        context,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "REPS",
                                      style: _historyLabelStyle(
                                        context,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "RIR",
                                      style: _historyLabelStyle(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                Dimensions.calculateHeight(
                                  8,
                                  context,
                                ),
                              ),

                              ...workoutExercise.sets.map(
                                    (set) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                      Dimensions.calculateHeight(
                                        5,
                                        context,
                                      ),
                                    ),

                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${set.setNumber}",
                                            style:
                                            _historyValueStyle(
                                              context,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            set.weight
                                                ?.toString() ??
                                                "-",
                                            style:
                                            _historyValueStyle(
                                              context,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            set.reps
                                                ?.toString() ??
                                                "-",
                                            style:
                                            _historyValueStyle(
                                              context,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            set.rir
                                                ?.toString() ??
                                                "-",
                                            style:
                                            _historyValueStyle(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
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

  TextStyle _historyLabelStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white.withValues(alpha: 0.4),
      fontSize: Dimensions.calculateHeight(11, context),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _historyValueStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white.withValues(alpha: 0.8),
      fontSize: Dimensions.calculateHeight(14, context),
    );
  }


}