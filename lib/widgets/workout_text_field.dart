import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/app_colors.dart';
import '../helper/dimensions.dart';

class WorkoutTextField extends StatelessWidget {
  const WorkoutTextField({super.key, required this.hintText, required this.valueChanged, required this.inputFormatters});

  final String hintText;
  final ValueChanged<String> valueChanged;
  final List<TextInputFormatter> inputFormatters;


  @override
  Widget build(BuildContext context) {
    return  Container(

      width: Dimensions.calculateWidth(80, context),
      height: Dimensions.calculateHeight(35, context),
      decoration: BoxDecoration(
        border: Border.all(
      color: Colors.grey,
      width: 1,
      ),
        borderRadius: BorderRadius.circular(
          Dimensions.calculateHeight(20, context),
        ),
        color: AppColors.accent,
        boxShadow: [
          BoxShadow(
              color: AppColors.surface.withValues(alpha: 0.8),
              offset: Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 3

          )
        ]
      ),

      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatters,
        onChanged: valueChanged,

        maxLength: 4,
        style: TextStyle(
          color: AppColors.textPrimary
        ),
        decoration: InputDecoration(
          counterText: "",
          isCollapsed: true,
          contentPadding: EdgeInsets.only(top: 2.0),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.textPrimary.withValues(alpha: 0.6),),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

        ),
      ),
    );
  }
}
