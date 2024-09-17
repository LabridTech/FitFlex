import 'package:app/common_widget/see_find_eat_cell.dart';
import 'package:app/constant/color.dart';
import 'package:app/data/excersise.dart';
import 'package:app/screens/gymseller/purchasemeal.dart';
import 'package:flutter/material.dart';

class SeemealPlan extends StatefulWidget {
  SeemealPlan({super.key});
  static String routeName = '/mealseller';
  @override
  State<SeemealPlan> createState() => SeemealPlanState();
}

List<dynamic> getcatogary(mealplan) {
  List yourfindEatArr = findEatArr;
  if (mealplan['break'].toString() == 'no') {
    yourfindEatArr.removeWhere((element) => element['name'] == "Breakfast");
  } else {
    List exc = mealplan['breaks'];
    int length = exc.length;
    yourfindEatArr[0]['number'] = "$length number";
  }
  if (mealplan['lunch'].toString() == 'no') {
    yourfindEatArr.removeWhere((element) => element['name'] == "Lunch");
  } else {
    List exc = mealplan['lunchs'];
    int length = exc.length;
    yourfindEatArr[1]['number'] = "$length number";
  }
  if (mealplan['dinner'].toString() == 'no') {
    yourfindEatArr.removeWhere((element) => element['name'] == 'Dinner');
  } else {
    var whatarr;
    int index = 0;
    for (whatarr in yourfindEatArr) {
      if (whatarr['name'] == 'Dinner') {
        print(1);
        break;
      }
      index++;
    }
    List exc = mealplan['dinners'];
    int length = exc.length;
    yourfindEatArr[index]['number'] = "$length number";
  }
  print(yourfindEatArr);

  return yourfindEatArr;
}

List<dynamic> getexcersise(title, plan) {
  List<dynamic> exsersise = [];
  if (title == "Breakfast") {
    for (var planexc in plan['breaks']) {
      for (var exc in recommendArr) {
        if (exc['name'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  } else if (title == "Lunch") {
    for (var planexc in plan['lunchs']) {
      for (var exc in recommendArr) {
        if (exc['name'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  } else if (title == "Dinner") {
    for (var planexc in plan['dinners']) {
      for (var exc in recommendArr) {
        if (exc['name'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  }

  return exsersise;
}

class SeemealPlanState extends State<SeemealPlan> {
  @override
  Widget build(context) {
    dynamic plan =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    double width = MediaQuery.of(context).size.width; // Gives the width
    double height = MediaQuery.of(context).size.height; // Gives the height
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          plan['Planname'],
          style: TextStyle(color: textcolorsecond),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text(
              plan['Price'],
              style: TextStyle(color: textcolor, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (Map arr in getcatogary(plan))
              SeeFindEatCell(
                fObj: arr,
                sObj: getexcersise(arr['name'], plan),
                index: 2,
              ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.blueGrey])),
              width: width - width * 2 / 10,
              height: height * 7 / 100,
              child: TextButton(
                onPressed: () {
                  // Handle button press event (e.g., navigate to home screen)
                  Navigator.pushReplacementNamed(
                      context, PurchaseMealScreen.routeName, arguments: {
                    'id': plan['id']
                  }); // Replace '/home' with your actual route name
                  //Navigator.pushNamed(context, '/profilecomplete',arguments: 'sasa');
                },
                child: const Text(
                  'Buy it',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
