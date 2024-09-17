import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:app/meal_planner/meal_planner_view.dart';
import 'package:app/screens/gymseller/meal_plans.dart';
import 'package:app/screens/gymseller/workoutplan.dart';
import 'package:app/screens/profilepage/profile.dart';
import 'package:app/screens/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PurchaseMealScreen extends StatefulWidget {
  static String routeName = '/purchasemeal';
  PurchaseMealScreen({super.key});

  Map<String, dynamic>? users;
  Future<Map<String, dynamic>?>? futureuser;
  @override
  _PurchaseMealScreen createState() => _PurchaseMealScreen();
}

class _PurchaseMealScreen extends State<PurchaseMealScreen> {
  Future<void> getdata(id) async {
    widget.futureuser = FirebaseCrud().buymeal(id);
    widget.users = await FirebaseCrud().buymeal(id);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    int id = int.parse(args['id'].toString());
    getdata(id);
    return FutureBuilder(
        future: widget.futureuser,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!['msg'] == 'success') {
              return Scaffold(
                backgroundColor: primary,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Thank you for the purchase',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, MealPlannerView.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text('To Meal'))
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: primary,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your purchase was unsuccessful',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Trainermealplans.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text('To Workout'))
                    ],
                  ),
                ),
              );
            }
          }
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.lightBlue,
              secondRingColor: Colors.blueAccent,
              thirdRingColor: const Color.fromARGB(255, 33, 82, 243),
              size: 100,
            ),
          );
        });
  }
}
