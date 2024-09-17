import 'package:app/firebase.dart';
import 'package:app/models/customermodal.dart';
import 'package:app/screens/Login_page/login_page.dart';
import 'package:app/screens/gymseller/TrainerInputPage.dart';
import 'package:app/screens/gymseller/add_meal_plan.dart';
import 'package:app/screens/gymseller/make_plan_page.dart';
import 'package:app/screens/gymseller/meal_plans.dart';
import 'package:app/screens/gymseller/trainer_plans.dart';
import 'package:app/screens/profilepage/profile.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  bool type;
  Customer customer;
  AccountCard({super.key, required this.type, required this.customer});

  Future<void> settype() async {
    await FirebaseCrud().settrainertype();
  }

  Widget build(context) {
    double screenwidth = MediaQuery.of(context).size.width; // Gives the width
    double height = MediaQuery.of(context).size.height; // Gives the height
    double iconmargin = screenwidth * 5 / 100;
    double textmargin = screenwidth * 5 / 100;
    double cardmargin = screenwidth * 6 / 100;
    return Container(
      margin: EdgeInsets.all(cardmargin),
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Account",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          if (type == true)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(iconmargin),
                  child: const Icon(
                    Icons.sports_gymnastics,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Make Plan",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (screenwidth * 3.75 / 10)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, MakePlan.routeName);
                    },
                  ),
                ),
              ],
            ),
          if (type == false && customer.workout.length == 4)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(iconmargin),
                  child: const Icon(
                    Icons.sports_gymnastics_sharp,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Buy Plan",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (screenwidth * 3.75 / 10)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, Trainerplans.routeName);
                    },
                  ),
                ),
              ],
            ),
          if (type == false && customer.meal.length == 4)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(iconmargin),
                  child: const Icon(
                    Icons.food_bank_outlined,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Buy Meal",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (screenwidth * 3.75 / 10)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, Trainermealplans.routeName);
                    },
                  ),
                ),
              ],
            ),
          if (type == true)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(iconmargin),
                  child: const Icon(
                    Icons.details_outlined,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Add Trianer Detail",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (screenwidth * 2.75 / 10)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, TrainerInputPage.routeName);
                    },
                  ),
                ),
              ],
            ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(iconmargin),
                child: const Icon(
                  Icons.swipe,
                  color: Colors.blueAccent,
                ),
              ),
              const Text(
                "Switch",
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
              ),
              Padding(
                padding: EdgeInsets.only(left: (screenwidth * 3.75 / 10)),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    settype();
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                ),
              ),
            ],
          ),
          if (type == true)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(iconmargin),
                  child: const Icon(
                    Icons.food_bank,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Add Meal",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (screenwidth * 3.75 / 10)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, MakeMealPlan.routeName);
                    },
                  ),
                ),
              ],
            ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(iconmargin),
                child: const Icon(
                  Icons.logout,
                  color: Colors.blueAccent,
                ),
              ),
              const Text(
                "logout",
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(123, 27, 27, 27)),
              ),
              Padding(
                padding: EdgeInsets.only(left: (screenwidth * 2.75 / 10)),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    FirebaseCrud().removeSessionvariable();
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
