import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/pages/home/main_page.dart';
import 'package:fitness_mvp/pages/workout/workout_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const MainPage(),
    const WorkoutPage(),
    const Center(
      child: Text(
        "History",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1D1F6E),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),

        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,

            indicatorColor: const Color(0xFF6C63FF),

            labelTextStyle: WidgetStateProperty.resolveWith(
                  (states) {
                if (states.contains(WidgetState.selected)) {
                  return const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  );
                }

                return TextStyle(
                  color: Colors.white.withValues(alpha: 0.45),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                );
              },
            ),
          ),

          child: NavigationBar(
            height: 70,

            selectedIndex: _selectedIndex,

            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },

            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
                selectedIcon: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                ),
                label: "Home",
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.fitness_center_outlined,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
                selectedIcon: const Icon(
                  Icons.fitness_center_rounded,
                  color: Colors.white,
                ),
                label: "Exercises",
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.history_rounded,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
                selectedIcon: const Icon(
                  Icons.history_rounded,
                  color: Colors.white,
                ),
                label: "History",
              ),
            ],
          ),
        ),
      ),
    );
  }
}