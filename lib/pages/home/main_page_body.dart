import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(
        top: Dimensions.calculateHeight(20, context),
        bottom: Dimensions.calculateHeight(20, context),
      ),
      padding: EdgeInsets.only(
        left: Dimensions.calculateWidth(20, context),
        right: Dimensions.calculateWidth(20, context),
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Start workout",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: Dimensions.calculateHeight(20, context),
            ),
          ),
          SizedBox(height: Dimensions.calculateHeight(30, context)),
          Container(
            width: double.maxFinite,
            height: Dimensions.calculateHeight(35, context),

            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.surface.withValues(alpha: 0.8),
                  offset: Offset(0, 2),
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
                "Start an empty workout",
                style: TextStyle(
                  fontSize: Dimensions.calculateHeight(16, context),
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.calculateHeight(50, context),),


        ],
      ),
    );
  }
}
