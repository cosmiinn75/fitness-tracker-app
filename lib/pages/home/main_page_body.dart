import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/pages/workout/workout_page.dart';
import 'package:flutter/material.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.calculateWidth(20, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.calculateHeight(25, context),
          ),

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

          Text(
            "Ready to train?",
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.calculateHeight(30, context),
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: Dimensions.calculateHeight(7, context),
          ),

          Text(
            "Start a workout and track every set, rep and weight.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: Dimensions.calculateHeight(15, context),
            ),
          ),

          SizedBox(
            height: Dimensions.calculateHeight(30, context),
          ),

          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(
              Dimensions.calculateWidth(20, context),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1F6E),
              borderRadius: BorderRadius.circular(
                Dimensions.calculateHeight(22, context),
              ),
              border: Border.all(
                color: const Color(0xFF34368A),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: Dimensions.calculateWidth(60, context),
                  height: Dimensions.calculateHeight(60, context),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF)
                        .withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.fitness_center_rounded,
                    color: const Color(0xFF8A84FF),
                    size: Dimensions.calculateHeight(28, context),
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(18, context),
                ),

                Text(
                  "Start an empty workout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.calculateHeight(21, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(7, context),
                ),

                Text(
                  "Build your workout from scratch by adding exercises and sets.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: Dimensions.calculateHeight(14, context),
                    height: 1.4,
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(22, context),
                ),

                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WorkoutPage()));
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.calculateHeight(50, context),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),
                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(16, context),
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
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: Dimensions.calculateHeight(24, context),
                        ),

                        SizedBox(
                          width: Dimensions.calculateWidth(6, context),
                        ),

                        Text(
                          "Start Workout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.calculateHeight(17, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: Dimensions.calculateHeight(30, context),
          ),
        ],
      ),
    );
  }
}