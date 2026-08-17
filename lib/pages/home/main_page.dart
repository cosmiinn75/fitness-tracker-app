import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:fitness_mvp/pages/home/main_page_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            color: AppColors.surface,
            padding: EdgeInsets.only(
              left: Dimensions.calculateWidth(20, context),
              right: Dimensions.calculateWidth(20, context),
            ),
            margin: EdgeInsets.only(
              bottom: Dimensions.calculateHeight(20, context),
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.calculateHeight(40, context),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fitness World",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: Dimensions.calculateHeight(24, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: Dimensions.calculateWidth(45, context),
                    height: Dimensions.calculateHeight(45, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.calculateHeight(15, context),
                      ),
                      color: AppColors.accent,
                    ),
                    child: Icon(Icons.person, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          MainPageBody()
        ],
      ),
    );
  }
}
