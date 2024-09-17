import 'package:app/data/excersise.dart';
import 'package:flutter/widgets.dart';

import '../../common_widget/meal_recommed_cell.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';

import '../../common_widget/popular_meal_row.dart';

import 'food_info_details_view.dart';

class MealFoodDetailsView extends StatefulWidget {
  final Map eObj;
  Map<String, dynamic> meal;
  String title;
  MealFoodDetailsView(
      {super.key, required this.eObj, required this.meal, required this.title});

  @override
  State<MealFoodDetailsView> createState() => _MealFoodDetailsViewState();
}

class _MealFoodDetailsViewState extends State<MealFoodDetailsView> {
  TextEditingController txtSearch = TextEditingController();

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
    print(exsersise);
    return exsersise;
  }

  List popularArr = [
    {
      "name": "Blueberry Pancake",
      "image": "images/f_1.png",
      "b_image": "images/pancake_1.png",
      "size": "Medium",
      "time": "30mins",
      "kcal": "230kCal"
    },
    {
      "name": "Salmon Nigiri",
      "image": "images/f_2.png",
      "b_image": "images/nigiri.png",
      "size": "Medium",
      "time": "20mins",
      "kcal": "120kCal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    int index = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.black,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "images/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          widget.eObj["name"].toString(),
          style: TextStyle(
              color: TColor.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "images/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Image.asset(
                          "images/search.png",
                          width: 25,
                          height: 25,
                        ),
                        hintText: "Search Pancake"),
                  )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 25,
                    color: TColor.gray.withOpacity(0.3),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "images/Filter.png",
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recommendation\nfor Diet",
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: media.width * 0.6,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                children: [
                  for (var fObj in getexcersise(widget.title, widget.meal))
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodInfoDetailsView(
                              dObj: fObj,
                              mObj: widget.eObj,
                            ),
                          ),
                        );
                      },
                      child: MealRecommendCell(
                        fObj: fObj,
                        index: index++,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Popular",
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: popularArr.length,
                itemBuilder: (context, index) {
                  var fObj = popularArr[index] as Map? ?? {};
                  return InkWell(
                    child: PopularMealRow(
                      mObj: fObj,
                      check: true,
                    ),
                  );
                }),
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
