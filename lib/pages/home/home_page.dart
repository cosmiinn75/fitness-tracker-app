import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/pages/home/main_page.dart';
import 'package:fitness_mvp/pages/workout/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  List pages = [
    MainPage(),
   WorkoutPage(),
    Container(child: Text("History"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(

          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.textPrimary,
          backgroundColor: AppColors.primary,
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add),label: "Start workout",backgroundColor: AppColors.primary),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Exercices"),
        BottomNavigationBarItem(icon: Icon(Icons.timer),label: "Hisory"),
      ]),
    );
  }
}
