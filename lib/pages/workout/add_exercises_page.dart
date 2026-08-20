import 'package:fitness_mvp/data/DTO/create_exercise_request.dart';
import 'package:fitness_mvp/data/controller/exercise_definition_controller.dart';
import 'package:fitness_mvp/data/model/exercise_definition.dart';
import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:flutter/material.dart';

class AddExercisesPage extends StatefulWidget {
  const AddExercisesPage({
    super.key,
    required this.unavailableExercises,
    required this.exerciseDefinitionController
  });

  final Set<int> unavailableExercises;
  final ExerciseDefinitionController exerciseDefinitionController;

  @override
  State<AddExercisesPage> createState() =>
      _AddExercisesPageState();
}

class _AddExercisesPageState extends State<AddExercisesPage> {
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

  bool isRemovePressed = false;

  List<ExerciseDefinition> selectedExercises = [];



  Future<void> showCreateExerciseDialog() async {
    final TextEditingController nameController =
    TextEditingController();

    String? selectedGroup;

    final ExerciseDefinition? newExercise =
    await showDialog<ExerciseDefinition>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1D1F6E),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.calculateHeight(
                    20,
                    context,
                  ),
                ),
              ),

              title: Text(
                "Create Exercise",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.calculateHeight(
                    21,
                    context,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Exercise name",
                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: 0.7,
                      ),
                      fontSize: Dimensions.calculateHeight(
                        14,
                        context,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height: Dimensions.calculateHeight(
                      8,
                      context,
                    ),
                  ),

                  TextField(
                    controller: nameController,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      hintText: "e.g. Cable Fly",

                      hintStyle: TextStyle(
                        color: Colors.white.withValues(
                          alpha: 0.35,
                        ),
                      ),

                      filled: true,

                      fillColor: const Color(
                        0xFF181A61,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),

                        borderSide: const BorderSide(
                          color: Color(0xFF34368A),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),

                        borderSide: const BorderSide(
                          color: Color(0xFF8A84FF),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Dimensions.calculateHeight(
                      18,
                      context,
                    ),
                  ),

                  Text(
                    "Muscle group",
                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: 0.7,
                      ),
                      fontSize: Dimensions.calculateHeight(
                        14,
                        context,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height: Dimensions.calculateHeight(
                      8,
                      context,
                    ),
                  ),

                  DropdownButtonFormField<String>(
                    initialValue: selectedGroup,

                    dropdownColor: const Color(
                      0xFF1D1F6E,
                    ),

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      filled: true,

                      fillColor: const Color(
                        0xFF181A61,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),

                        borderSide: const BorderSide(
                          color: Color(0xFF34368A),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),

                        borderSide: const BorderSide(
                          color: Color(0xFF8A84FF),
                        ),
                      ),
                    ),

                    hint: Text(
                      "Select muscle group",
                      style: TextStyle(
                        color: Colors.white.withValues(
                          alpha: 0.35,
                        ),
                      ),
                    ),

                    items: muscleGroups.map((muscleGroup) {
                      return DropdownMenuItem<String>(
                        value: muscleGroup,
                        child: Text(muscleGroup),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setDialogState(() {
                        selectedGroup = value;
                      });
                    },
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },

                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF6C63FF),

                    foregroundColor: Colors.white,
                  ),

                  onPressed: () async{
                    final String exerciseName =
                    nameController.text.trim();

                    if (exerciseName.isEmpty ||
                        selectedGroup == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete both fields")));
                      return;
                    }


                    if (widget.exerciseDefinitionController.exerciseExists(exerciseName, selectedGroup!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An exercise with this name already exists."),
                        ),
                      );
                      return;
                    }



                    ExerciseDefinition exercise = await widget.exerciseDefinitionController.createExercise(CreateExerciseRequest(exerciseName: exerciseName, muscleGroup: selectedGroup!.toUpperCase()));


                    if(!mounted){
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      exercise,
                    );
                  },

                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (newExercise != null) {
      setState(() {
        selectedExercises.add(newExercise);
        print("added exercise");
      });
    }

    nameController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final List<ExerciseDefinition> filteredExercises =
    widget.exerciseDefinitionController.exercises.where((exercise) {
      final bool matchesSearch = exercise.exerciseName
          .toLowerCase()
          .contains(
        searchQuery.trim().toLowerCase(),
      );

      final bool matchesMuscleGroup =
          selectedMuscleGroup == null ||
              exercise.muscleGroup ==
                  muscleGroups[selectedMuscleGroup!];

      return matchesSearch &&
          matchesMuscleGroup;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
            Dimensions.calculateWidth(
              20,
              context,
            ),
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: Dimensions.calculateHeight(
                  20,
                  context,
                ),
              ),

              // HEADER
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      width:
                      Dimensions.calculateWidth(
                        40,
                        context,
                      ),

                      height:
                      Dimensions.calculateHeight(
                        40,
                        context,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF1D1F6E,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          Dimensions.calculateHeight(
                            12,
                            context,
                          ),
                        ),
                      ),

                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,

                          color: Colors.white,

                          size:
                          Dimensions.calculateHeight(
                            18,
                            context,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width:
                    Dimensions.calculateWidth(
                      15,
                      context,
                    ),
                  ),

                  Text(
                    "Add Exercises",
                    style: TextStyle(
                      color: Colors.white,

                      fontSize:
                      Dimensions.calculateHeight(
                        26,
                        context,
                      ),

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      if (selectedExercises.isEmpty) {
                        return;
                      }

                      Navigator.pop(
                        context,
                        selectedExercises,
                      );
                    },

                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 180,
                      ),

                      height:
                      Dimensions.calculateHeight(
                        38,
                        context,
                      ),

                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        Dimensions.calculateWidth(
                          13,
                          context,
                        ),
                      ),

                      decoration: BoxDecoration(
                        color:
                        selectedExercises.isNotEmpty
                            ? const Color(
                          0xFF6C63FF,
                        )
                            : const Color(
                          0xFF1D1F6E,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          Dimensions.calculateHeight(
                            14,
                            context,
                          ),
                        ),

                        border: Border.all(
                          color:
                          selectedExercises.isNotEmpty
                              ? const Color(
                            0xFF8A84FF,
                          )
                              : const Color(
                            0xFF34368A,
                          ),
                        ),
                      ),

                      child: Row(
                        mainAxisSize:
                        MainAxisSize.min,

                        children: [
                          Text(
                            "Add",
                            style: TextStyle(
                              color: selectedExercises
                                  .isNotEmpty
                                  ? Colors.white
                                  : Colors.white
                                  .withValues(
                                alpha: 0.4,
                              ),

                              fontSize:
                              Dimensions.calculateHeight(
                                16,
                                context,
                              ),

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          if (selectedExercises
                              .isNotEmpty) ...[
                            SizedBox(
                              width:
                              Dimensions.calculateWidth(
                                4,
                                context,
                              ),
                            ),

                            Text(
                              "(${selectedExercises.length})",
                              style: TextStyle(
                                color: Colors.white,

                                fontSize:
                                Dimensions.calculateHeight(
                                  12,
                                  context,
                                ),

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: Dimensions.calculateHeight(
                  25,
                  context,
                ),
              ),

              // SEARCH
              Container(
                height: Dimensions.calculateHeight(
                  50,
                  context,
                ),

                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1D1F6E,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    Dimensions.calculateHeight(
                      16,
                      context,
                    ),
                  ),

                  border: Border.all(
                    color: const Color(
                      0xFF34368A,
                    ),
                  ),
                ),

                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,

                      color: Colors.white.withValues(
                        alpha: 0.6,
                      ),
                    ),

                    hintText: "Search exercises",

                    hintStyle: TextStyle(
                      color: Colors.white
                          .withValues(
                        alpha: 0.45,
                      ),
                    ),

                    border: InputBorder.none,

                    contentPadding:
                    EdgeInsets.symmetric(
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
                height: Dimensions.calculateHeight(
                  25,
                  context,
                ),
              ),

              Text(
                "Muscle group",

                style: TextStyle(
                  color: Colors.white,

                  fontSize:
                  Dimensions.calculateHeight(
                    18,
                    context,
                  ),

                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(
                  12,
                  context,
                ),
              ),

              // MUSCLE GROUPS
              Wrap(
                spacing:
                Dimensions.calculateWidth(
                  10,
                  context,
                ),

                runSpacing:
                Dimensions.calculateHeight(
                  10,
                  context,
                ),

                children:
                List.generate(
                  muscleGroups.length,
                      (index) {
                    final bool selected =
                        selectedMuscleGroup ==
                            index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedMuscleGroup ==
                              index) {
                            selectedMuscleGroup =
                            null;
                          } else {
                            selectedMuscleGroup =
                                index;
                          }
                        });
                      },

                      child:
                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),

                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(
                            18,
                            context,
                          ),

                          vertical:
                          Dimensions.calculateHeight(
                            10,
                            context,
                          ),
                        ),

                        decoration:
                        BoxDecoration(
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

                          border:
                          Border.all(
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
                            color:
                            Colors.white,

                            fontSize:
                            Dimensions.calculateHeight(
                              15,
                              context,
                            ),

                            fontWeight:
                            selected
                                ? FontWeight
                                .bold
                                : FontWeight
                                .normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(
                  25,
                  context,
                ),
              ),

              // EXERCISES TITLE + BUTTONS
              Row(
                children: [
                  Text(
                    "Exercises",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize:
                      Dimensions.calculateHeight(
                        18,
                        context,
                      ),

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  // CREATE EXERCISE
                  GestureDetector(
                    onTap: () {
                      showCreateExerciseDialog();
                    },

                    child: Container(
                      width:
                      Dimensions.calculateWidth(
                        40,
                        context,
                      ),

                      height:
                      Dimensions.calculateHeight(
                        40,
                        context,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF6C63FF,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          Dimensions.calculateHeight(
                            13,
                            context,
                          ),
                        ),

                        border: Border.all(
                          color: const Color(
                            0xFF8A84FF,
                          ),
                        ),
                      ),

                      child: Icon(
                        Icons.add_rounded,

                        color: Colors.white,

                        size:
                        Dimensions.calculateHeight(
                          24,
                          context,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width:
                    Dimensions.calculateWidth(
                      10,
                      context,
                    ),
                  ),

                  // REMOVE ALL
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        isRemovePressed = true;
                      });
                    },

                    onTapUp: (_) {
                      setState(() {
                        isRemovePressed = false;
                      });
                    },

                    onTapCancel: () {
                      setState(() {
                        isRemovePressed = false;
                      });
                    },

                    onTap: () {
                      setState(() {
                        selectedExercises.clear();
                      });
                    },

                    child: AnimatedScale(
                      duration:
                      const Duration(
                        milliseconds: 180,
                      ),

                      scale: isRemovePressed
                          ? 0.9
                          : 1.0,

                      child:
                      AnimatedContainer(
                        duration:
                        const Duration(
                          milliseconds: 120,
                        ),

                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(
                            14,
                            context,
                          ),

                          vertical:
                          Dimensions.calculateHeight(
                            10,
                            context,
                          ),
                        ),

                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            Dimensions.calculateHeight(
                              15,
                              context,
                            ),
                          ),

                          color:
                          isRemovePressed
                              ? const Color(
                            0xFFB83A4B,
                          )
                              : const Color(
                            0xFF1D1F6E,
                          ),

                          border:
                          Border.all(
                            color:
                            const Color(
                              0xFF34368A,
                            ),
                          ),
                        ),

                        child: Text(
                          "Remove all",

                          style: TextStyle(
                            color:
                            Colors.white,

                            fontSize:
                            Dimensions.calculateHeight(
                              14,
                              context,
                            ),

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: Dimensions.calculateHeight(
                  10,
                  context,
                ),
              ),

              // EXERCISES LIST
              Expanded(
                child: filteredExercises.isEmpty
                    ? Center(
                  child: Text(
                    "No exercises found.",

                    style: TextStyle(
                      color: Colors.white
                          .withValues(
                        alpha: 0.4,
                      ),

                      fontSize:
                      Dimensions.calculateHeight(
                        15,
                        context,
                      ),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount:
                  filteredExercises.length,

                  itemBuilder:
                      (context, index) {
                    final ExerciseDefinition
                    exercise =
                    filteredExercises[
                    index];

                    final bool unavailable =
                    widget
                        .unavailableExercises
                        .contains(
                      exercise.id,
                    );

                    final bool isSelected =
                    selectedExercises
                        .contains(
                      exercise,
                    );

                    return GestureDetector(
                      onTap: () {
                        if (unavailable) {
                          return;
                        }

                        setState(() {
                          if (selectedExercises
                              .contains(
                            exercise,
                          )) {
                            selectedExercises
                                .remove(
                              exercise,
                            );
                          } else {
                            selectedExercises
                                .add(
                              exercise,
                            );
                          }
                        });
                      },

                      child:
                      AnimatedContainer(
                        duration:
                        const Duration(
                          milliseconds:
                          180,
                        ),

                        height:
                        Dimensions.calculateHeight(
                          54,
                          context,
                        ),

                        width:
                        double.maxFinite,

                        margin:
                        EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(
                            5,
                            context,
                          ),

                          vertical:
                          Dimensions.calculateHeight(
                            5,
                            context,
                          ),
                        ),

                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(
                            18,
                            context,
                          ),
                        ),

                        decoration:
                        BoxDecoration(
                          color: unavailable
                              ? const Color(
                            0xFF16184F,
                          )
                              : isSelected
                              ? const Color(
                            0xFF6C63FF,
                          )
                              : const Color(
                            0xFF1D1F6E,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            Dimensions.calculateHeight(
                              18,
                              context,
                            ),
                          ),

                          border:
                          Border.all(
                            color: unavailable
                                ? const Color(
                              0xFF34368A,
                            ).withValues(
                              alpha:
                              0.5,
                            )
                                : isSelected
                                ? const Color(
                              0xFF8A84FF,
                            )
                                : const Color(
                              0xFF34368A,
                            ),
                          ),
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                exercise.exerciseName,

                                overflow:
                                TextOverflow
                                    .ellipsis,

                                style:
                                TextStyle(
                                  color: unavailable
                                      ? Colors.white
                                      .withValues(
                                    alpha:
                                    0.35,
                                  )
                                      : Colors
                                      .white,

                                  fontSize:
                                  Dimensions.calculateHeight(
                                    17,
                                    context,
                                  ),

                                  fontWeight:
                                  isSelected
                                      ? FontWeight
                                      .bold
                                      : FontWeight
                                      .normal,
                                ),
                              ),
                            ),

                            SizedBox(
                              width:
                              Dimensions.calculateWidth(
                                10,
                                context,
                              ),
                            ),

                            Text(
                              exercise
                                  .muscleGroup,

                              style:
                              TextStyle(
                                color: unavailable
                                    ? Colors.white
                                    .withValues(
                                  alpha:
                                  0.20,
                                )
                                    : Colors.white
                                    .withValues(
                                  alpha:
                                  0.6,
                                ),

                                fontSize:
                                Dimensions.calculateHeight(
                                  14,
                                  context,
                                ),

                                fontWeight:
                                isSelected
                                    ? FontWeight
                                    .bold
                                    : FontWeight
                                    .normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(
                  20,
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}