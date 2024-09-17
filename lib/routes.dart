import 'package:app/meal_planner/meal_planner_view.dart';
import 'package:app/screens/Login_page/login_page.dart';
import 'package:app/screens/Register_page/register_page.dart';
import 'package:app/screens/complete_profile_page/complete_profile_page.dart';
import 'package:app/screens/errorpage/errorscreen.dart';
import 'package:app/screens/gymseller/TrainerInputPage.dart';
import 'package:app/screens/gymseller/add_meal_plan.dart';
import 'package:app/screens/gymseller/make_plan_page.dart';
import 'package:app/screens/gymseller/meal_plans.dart';
import 'package:app/screens/gymseller/mealplan.dart';
import 'package:app/screens/gymseller/purchase.dart';
import 'package:app/screens/gymseller/purchasemeal.dart';
import 'package:app/screens/gymseller/trainer_plans.dart';
import 'package:app/screens/gymseller/workoutplan.dart';
import 'package:app/screens/profilepage/Trainer_Profile_Page.dart';
import 'package:app/screens/profilepage/home_view.dart';
import 'package:app/screens/profilepage/profile.dart';
import 'package:app/screens/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/widgets.dart';
import 'screens/startpage.dart';

final Map<String, WidgetBuilder> routes = {
  StartScreen.routeName: (context) => StartScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CompleteProfile.routeName: (context) => CompleteProfile(),
  Trainerplans.routeName: (context) => Trainerplans(),
  WorkoutTrackerView.routeName: (context) => WorkoutTrackerView(),
  WorkoutPlan.routeName: (context) => WorkoutPlan(),
  MakePlan.routeName: (context) => MakePlan(),
  HomeView.routeName: (context) => HomeView(),
  PurchaseScreen.routeName: (context) => PurchaseScreen(),
  MealPlannerView.routeName: (context) => MealPlannerView(),
  Trainermealplans.routeName: (context) => Trainermealplans(),
  SeemealPlan.routeName: (context) => SeemealPlan(),
  PurchaseMealScreen.routeName: (context) => PurchaseMealScreen(),
  MakeMealPlan.routeName: (context) => MakeMealPlan(),
  TrainerInputPage.routeName: (context) => TrainerInputPage(),
  TrainerProfilePage.routeName: (context) => TrainerProfilePage(),
};
