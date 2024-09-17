import 'package:app/meal_planner/meal_planner_view.dart';

import 'package:app/screens/profilepage/home_view.dart';
import 'package:app/screens/profilepage/profile.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  Bottom({super.key});
  @override
  _Bottom createState() => _Bottom();
}

class _Bottom extends State<Bottom> {
  static bool toggle = false;
  @override
  Widget build(context) {
    return CircleNavBar(
      activeIcons: const [
        Icon(Icons.sports_gymnastics, color: Colors.black),
        Icon(Icons.home, color: Colors.black),
        Icon(Icons.fastfood_sharp, color: Colors.black),
      ],
      inactiveIcons: const [
        Icon(Icons.sports_gymnastics, color: Colors.black),
        Icon(Icons.home, color: Colors.black),
        Icon(Icons.fastfood_sharp, color: Colors.black),
      ],
      color: Colors.grey,
      circleColor: Colors.blue,
      height: 60,
      circleWidth: 60,
      activeIndex: 1,
      onTap: (index) {
        setState(() {
          print(index);
          if (index == 0) {
            Navigator.pushNamed(context, '/trackerview');
          } else if (index == 1) {
            if (toggle) {
              Navigator.pushNamed(context, ProfileScreen.routeName);
              toggle = false;
            } else {
              Navigator.pushNamed(context, HomeView.routeName);
              toggle = true;
            }
          } else if (index == 2) {
            Navigator.pushNamed(context, MealPlannerView.routeName);
          }
        });
      },
    );
  }
}
