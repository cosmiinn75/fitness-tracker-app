import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/dimensions.dart';

class WorkoutTextField extends StatefulWidget {
   WorkoutTextField({
    super.key,
    required this.hintText,
    required this.valueChanged,
    required this.inputFormatters,
     this.initialValue
  });

  final String hintText;
  final ValueChanged<String> valueChanged;
  final List<TextInputFormatter> inputFormatters;
  String? initialValue;

  @override
  State<WorkoutTextField> createState() => _WorkoutTextFieldState();
}

class _WorkoutTextFieldState extends State<WorkoutTextField> {
  bool isFocused = false;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue ?? "",
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),

        width: Dimensions.calculateWidth(80, context),
        height: Dimensions.calculateHeight(38, context),

        decoration: BoxDecoration(
          color: isFocused
              ? const Color(0xFF25277A)
              : const Color(0xFF181A61),

          borderRadius: BorderRadius.circular(
            Dimensions.calculateHeight(12, context),
          ),

          border: Border.all(
            color: isFocused
                ? const Color(0xFF8A84FF)
                : const Color(0xFF34368A),
            width: isFocused ? 1.5 : 1,
          ),

          boxShadow: isFocused
              ? [
            BoxShadow(
              color: const Color(0xFF6C63FF)
                  .withValues(alpha: 0.18),
              blurRadius: 8,
            ),
          ]
              : [],
        ),

        child: TextField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),

          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,

          inputFormatters: widget.inputFormatters,

          onChanged: widget.valueChanged,

          maxLength: 4,

          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.calculateHeight(16, context),
            fontWeight: FontWeight.w600,
          ),

          decoration: InputDecoration(
            counterText: "",

            hintText: widget.hintText,

            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.28),
              fontSize: Dimensions.calculateHeight(15, context),
              fontWeight: FontWeight.normal,
            ),

            isCollapsed: true,

            contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.calculateHeight(9, context),
              horizontal: Dimensions.calculateWidth(6, context),
            ),

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}