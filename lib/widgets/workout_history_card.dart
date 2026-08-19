import 'package:fitness_mvp/data/model/workout_draft.dart';
import 'package:flutter/material.dart';

import '../helper/dimensions.dart';

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({
    super.key,
    required this.workout,
  });

  final WorkoutDraft workout;

  @override
  Widget build(BuildContext context) {
    final int totalSets = workout.exercises.fold<int>(
      0,
          (sum, exercise) => sum + exercise.sets.length,
    );

    return Container(
      width: double.maxFinite,

      margin: EdgeInsets.only(
        bottom: Dimensions.calculateHeight(14, context),
      ),

      padding: EdgeInsets.all(
        Dimensions.calculateWidth(18, context),
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF1D1F6E),

        borderRadius: BorderRadius.circular(
          Dimensions.calculateHeight(20, context),
        ),

        border: Border.all(
          color: const Color(0xFF34368A),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ICON
          Container(
            width: Dimensions.calculateWidth(48, context),
            height: Dimensions.calculateHeight(48, context),

            decoration: BoxDecoration(
              color: const Color(
                0xFF6C63FF,
              ).withValues(alpha: 0.16),

              borderRadius: BorderRadius.circular(
                Dimensions.calculateHeight(14, context),
              ),
            ),

            child: Icon(
              Icons.fitness_center_rounded,
              color: const Color(0xFF8A84FF),
              size: Dimensions.calculateHeight(23, context),
            ),
          ),

          SizedBox(
            width: Dimensions.calculateWidth(14, context),
          ),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.workoutName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                    Dimensions.calculateHeight(19, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(4, context),
                ),

                Text(
                  "${workout.date.day}/${workout.date.month}/${workout.date.year}",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.42),
                    fontSize:
                    Dimensions.calculateHeight(13, context),
                  ),
                ),

                SizedBox(
                  height: Dimensions.calculateHeight(10, context),
                ),

                Row(
                  children: [
                    _buildStat(
                      context,
                      Icons.fitness_center_outlined,
                      "${workout.exercises.length} exercises",
                    ),

                    SizedBox(
                      width:
                      Dimensions.calculateWidth(14, context),
                    ),

                    _buildStat(
                      context,
                      Icons.format_list_numbered_rounded,
                      "$totalSets sets",
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            width: Dimensions.calculateWidth(8, context),
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white.withValues(alpha: 0.3),
            size: Dimensions.calculateHeight(17, context),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
      BuildContext context,
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFFAAA6FF),
          size: Dimensions.calculateHeight(15, context),
        ),

        SizedBox(
          width: Dimensions.calculateWidth(5, context),
        ),

        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: Dimensions.calculateHeight(13, context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}