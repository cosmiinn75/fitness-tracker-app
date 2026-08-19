import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:flutter/material.dart';

import '../../data/model/exercise_definition.dart';

class AddExercisesPage extends StatefulWidget {
  const AddExercisesPage({super.key, required this.unavailableExercises});

  final Set<int> unavailableExercises;

  @override
  State<AddExercisesPage> createState() => _AddExercisesPageState();
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

  final List<ExerciseDefinition> mockExercises = [
    ExerciseDefinition(
      id: 1,
      name: "Bench Press",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 2,
      name: "Incline Bench Press",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 3,
      name: "Dumbbell Fly",
      muscleGroup: "Chest",
    ),
    ExerciseDefinition(
      id: 4,
      name: "Lat Pulldown",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 5,
      name: "Barbell Row",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 6,
      name: "Pull Up",
      muscleGroup: "Back",
    ),
    ExerciseDefinition(
      id: 7,
      name: "Biceps Curl",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 8,
      name: "Hammer Curl",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 9,
      name: "Triceps Pushdown",
      muscleGroup: "Arms",
    ),
    ExerciseDefinition(
      id: 10,
      name: "Shoulder Press",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 11,
      name: "Lateral Raise",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 12,
      name: "Rear Delt Fly",
      muscleGroup: "Shoulders",
    ),
    ExerciseDefinition(
      id: 13,
      name: "Squat",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 14,
      name: "Leg Press",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 15,
      name: "Leg Curl",
      muscleGroup: "Legs",
    ),
    ExerciseDefinition(
      id: 16,
      name: "Plank",
      muscleGroup: "Core",
    ),
    ExerciseDefinition(
      id: 17,
      name: "Crunch",
      muscleGroup: "Core",
    ),
    ExerciseDefinition(
      id: 18,
      name: "Hanging Leg Raise",
      muscleGroup: "Core",
    ),
  ];

  @override
  Widget build(BuildContext context) {
      final List<ExerciseDefinition> filteredExercises =
          mockExercises
      .where((exercise) {
            bool matchesSearch = exercise.name.toLowerCase().contains(searchQuery.trim().toLowerCase());

            bool matchesMuscleGroup = selectedMuscleGroup == null || exercise.muscleGroup == muscleGroups[selectedMuscleGroup!];


            return matchesMuscleGroup && matchesSearch;
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.calculateWidth(20, context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.calculateHeight(20, context),
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Dimensions.calculateWidth(40, context),
                      height: Dimensions.calculateHeight(40, context),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1F6E),
                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(12, context),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: Dimensions.calculateHeight(18, context),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: Dimensions.calculateWidth(15, context),
                  ),

                  Text(
                    "Add Exercises",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.calculateHeight(28, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(

                    onTap:(){

                      Navigator.pop(context,selectedExercises);

                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: Dimensions.calculateHeight(38, context),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.calculateWidth(13, context),
                      ),
                      decoration: BoxDecoration(
                        color: selectedExercises.isNotEmpty
                            ? const Color(0xFF6C63FF)
                            : const Color(0xFF1D1F6E),

                        borderRadius: BorderRadius.circular(
                          Dimensions.calculateHeight(14, context),
                        ),

                        border: Border.all(
                          color: selectedExercises.isNotEmpty
                              ? const Color(0xFF8A84FF)
                              : const Color(0xFF34368A),
                        ),

                        boxShadow: selectedExercises.isNotEmpty
                            ? [
                          BoxShadow(
                            color: const Color(
                              0xFF6C63FF,
                            ).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                            : [],
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(
                              color: selectedExercises.isNotEmpty
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                              fontSize:
                              Dimensions.calculateHeight(16, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          if (selectedExercises.isNotEmpty) ...[
                            SizedBox(
                              width: Dimensions.calculateWidth(4, context),
                            ),

                            Container(
                              width: Dimensions.calculateWidth(22, context),
                              height: Dimensions.calculateHeight(22, context),
                              alignment: Alignment.center,
                              child: Text(
                                "(${selectedExercises.length})",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  Dimensions.calculateHeight(12, context),
                                  fontWeight: FontWeight.bold,
                                ),
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
                height: Dimensions.calculateHeight(25, context),
              ),

              Container(
                height: Dimensions.calculateHeight(50, context),
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
                  onChanged: (value){
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    hintText: "Search exercises",
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.calculateHeight(14, context),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(25, context),
              ),

              Text(
                "Muscle group",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.calculateHeight(18, context),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: Dimensions.calculateHeight(12, context),
              ),

              Wrap(
                spacing: Dimensions.calculateWidth(10, context),
                runSpacing: Dimensions.calculateHeight(10, context),
                children: List.generate(
                  muscleGroups.length,
                      (index) {
                    final bool selected =
                        selectedMuscleGroup == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedMuscleGroup == index) {
                            selectedMuscleGroup = null;
                          } else {
                            selectedMuscleGroup = index;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(18, context),
                          vertical:
                          Dimensions.calculateHeight(10, context),
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF6C63FF)
                              : const Color(0xFF1D1F6E),

                          borderRadius: BorderRadius.circular(
                            Dimensions.calculateHeight(20, context),
                          ),

                          border: Border.all(
                            color: selected
                                ? const Color(0xFF8A84FF)
                                : const Color(0xFF34368A),
                          ),
                        ),
                        child: Text(
                          muscleGroups[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            Dimensions.calculateHeight(15, context),
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

              SizedBox(
                height: Dimensions.calculateHeight(30, context),
              ),

              Row(

                children: [
                  Text(
                    "Exercises",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.calculateHeight(18, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(

                   onTapDown: (details){
                     setState(() {
                       isRemovePressed = true;
                     });
                   },
                    onTapUp: (details){
                      setState(() {
                        isRemovePressed = false;
                      });
                    },

                    onTapCancel: (){
                      setState(() {
                        isRemovePressed = false;
                      });
                    },

                    onTap: (){
                      setState(() {
                        selectedExercises.clear();
                      });
                    },
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 180),
                      scale: isRemovePressed ? 0.9 : 1.0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 120),

                        padding: EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(18, context),
                          vertical:
                          Dimensions.calculateHeight(10, context),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.calculateHeight(15, context)),
                          color: !isRemovePressed ? const Color(0xFF1D1F6E) : Colors.red,
                        ),
                        child: Text(
                          "Remove all",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(18, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: Dimensions.calculateHeight(10, context),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
                    bool unavailable = widget.unavailableExercises.contains(exercise.id);

                    final isSelected =
                    selectedExercises.contains(exercise);

                    return GestureDetector(
                      onTap: () {
                        if(unavailable){
                          return;
                        }
                        setState(() {

                          if (selectedExercises.contains(exercise)) {
                            selectedExercises.remove(exercise);
                          } else {
                            selectedExercises.add(exercise);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: Dimensions.calculateHeight(50, context),
                        width: double.maxFinite,

                        margin: EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(10, context),
                          vertical:
                          Dimensions.calculateHeight(5, context),
                        ),

                        padding: EdgeInsets.symmetric(
                          horizontal:
                          Dimensions.calculateWidth(18, context),
                          vertical:
                          Dimensions.calculateHeight(10, context),
                        ),

                        decoration: BoxDecoration(
                          color:unavailable ? const Color(0xFF16184F) : (isSelected
                              ? const Color(0xFF6C63FF)
                              : const Color(0xFF1D1F6E)),

                          borderRadius: BorderRadius.circular(
                            Dimensions.calculateHeight(20, context),
                          ),

                          border: Border.all(
                            color:  unavailable ? const Color(0xFF34368A).withValues(alpha: 0.5) : (isSelected
                                ? const Color(0xFF8A84FF)
                                : const Color(0xFF34368A)),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              exercise.name,
                              style: TextStyle(
                                color: unavailable ? Colors.white.withValues(alpha: 0.35) : Colors.white,
                                fontSize:
                                Dimensions.calculateHeight(20, context),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),

                            Text(
                              exercise.muscleGroup,
                              style: TextStyle(
                                color:unavailable ? Colors.white.withValues(alpha: 0.20) : Colors.white.withValues(alpha: 0.6),
                                fontSize:
                                Dimensions.calculateHeight(18, context),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
                height: Dimensions.calculateHeight(30, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}