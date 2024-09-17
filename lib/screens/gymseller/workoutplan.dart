import 'package:app/common_widget/traindetails.dart';
import 'package:app/constant/color.dart';
import 'package:app/data/excersise.dart';
import 'package:app/screens/gymseller/purchase.dart';
import 'package:flutter/material.dart';

class WorkoutPlan extends StatefulWidget {
  WorkoutPlan({super.key});
  static String routeName = '/seller';
  @override
  State<WorkoutPlan> createState() => WorkoutPlanState();
}

List<dynamic> getcatogary(plan) {
  var whatcatogryArr = catagoryArr;
  if (plan['exc_chest'].toString() == 'no') {
    whatcatogryArr
        .removeWhere((element) => element['title'] == "Chest Workout");
  } else {
    List exc = plan['excs_chest'];
    int length = exc.length;
    whatcatogryArr[0]['exercises'] = "$length exercises";
  }
  if (plan['exc_lower'].toString() == 'no') {
    whatcatogryArr
        .removeWhere((element) => element['title'] == "Lowerbody Workout");
  } else {
    List exc = plan['excs_lower'];
    int length = exc.length;
    whatcatogryArr[1]['exercises'] = "$length exercises";
  }
  if (plan['exc_abs'].toString() == 'no') {
    whatcatogryArr.removeWhere((element) => element['title'] == "AB Workout");
  } else {
    var whatarr;
    int index = 0;
    for (whatarr in whatcatogryArr) {
      if (whatarr['title'] == 'AB Workout') {
        break;
      }
      index++;
    }
    List exc = plan['excs_abs'];
    int length = exc.length;
    whatcatogryArr[index]['exercises'] = "$length exercises";
  }
  return whatcatogryArr;
}

List<dynamic> getexcersise(title, plan) {
  List<dynamic> exsersise = [];
  if (title == "Chest Workout") {
    for (var planexc in plan['excs_chest']) {
      for (var exc in exercisesArr[0]['set']) {
        if (exc['title'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  } else if (title == "Lowerbody Workout") {
    for (var planexc in plan['excs_lower']) {
      for (var exc in exercisesArr[1]['set']) {
        print(planexc);
        print(exc['title']);
        if (exc['title'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  } else if (title == "AB Workout") {
    for (var planexc in plan['excs_abs']) {
      for (var exc in exercisesArr[2]['set']) {
        if (exc['title'].toString() == planexc.toString()) {
          exsersise.add(exc);
        }
      }
    }
  }
  print(exsersise);
  return exsersise;
}

class WorkoutPlanState extends State<WorkoutPlan> {
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
      body: Column(
        children: [
          for (Map arr in getcatogary(plan))
            TrainDetails(wObj: arr, sObj: getexcersise(arr['title'], plan)),
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
                    context, PurchaseScreen.routeName, arguments: {
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
    );
  }
}
