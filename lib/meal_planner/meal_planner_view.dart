import 'package:app/data/excersise.dart';
import 'package:app/firebase.dart';
import 'package:app/screens/errorpage/workouterrorscreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/find_eat_cell.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_meal_row.dart';
import 'meal_food_details_view.dart';

class MealPlannerView extends StatefulWidget {
  MealPlannerView({super.key});
  static String routeName = '/meal';
  Map<String, dynamic>? mealplan;
  Future<Map<String, dynamic>?>? futuremealplan;

  @override
  State<MealPlannerView> createState() => _MealPlannerViewState();
}

class _MealPlannerViewState extends State<MealPlannerView> {
  List yourfindEatArr = [];

  Future<void> getdata() async {
    widget.futuremealplan = FirebaseCrud().getfood();
    widget.mealplan = await FirebaseCrud().getfood();
    yourexerciseArr = exercisesArr;
    yourfindEatArr = findEatArr;
    if (widget.mealplan?['break'].toString() == 'no') {
      yourfindEatArr.removeWhere((element) => element['name'] == "Breakfast");
    } else {
      List exc = widget.mealplan?['breaks'];
      int length = exc.length;
      yourfindEatArr[0]['number'] = "$length number";
    }
    if (widget.mealplan?['lunch'].toString() == 'no') {
      yourfindEatArr.removeWhere((element) => element['name'] == "Lunch");
    } else {
      List exc = widget.mealplan?['lunchs'];
      int length = exc.length;
      yourfindEatArr[1]['number'] = "$length number";
    }
    if (widget.mealplan?['dinner'].toString() == 'no') {
      yourfindEatArr.removeWhere((element) => element['name'] == 'Dinner');
    } else {
      var whatarr;
      int index = 0;
      for (whatarr in yourfindEatArr) {
        if (whatarr['title'] == 'Dinner') {
          print(1);
          break;
        }
        index++;
      }
      List exc = widget.mealplan?['dinners'];
      int length = exc.length;
      yourfindEatArr[index]['number'] = "$length number";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    getdata();
    return FutureBuilder(
        future: widget.futuremealplan,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!['error'] == 'no workout') {
              return WorkoutErrorScreen(errormsg: 'no Meal ');
            }
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
                  "Meal Planner",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Meal Nutritions",
                                style: TextStyle(
                                    color: TColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: TColor.primaryG),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: ["Weekly", "Monthly"]
                                          .map((name) => DropdownMenuItem(
                                                value: name,
                                                child: Text(
                                                  name,
                                                  style: TextStyle(
                                                      color: TColor.gray,
                                                      fontSize: 14),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {},
                                      icon: Icon(Icons.expand_more,
                                          color: TColor.white),
                                      hint: Text(
                                        "Weekly",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: TColor.white, fontSize: 12),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 15),
                              height: media.width * 0.5,
                              width: double.maxFinite,
                              child: LineChart(
                                LineChartData(
                                  // showingTooltipIndicators:
                                  //     showingTooltipOnSpots.map((index) {
                                  //   return ShowingTooltipIndicators([
                                  //     LineBarSpot(
                                  //       tooltipsOnBar,
                                  //       lineBarsData.indexOf(tooltipsOnBar),
                                  //       tooltipsOnBar.spots[index],
                                  //     ),
                                  //   ]);
                                  // }).toList(),
                                  lineTouchData: LineTouchData(
                                    enabled: true,
                                    handleBuiltInTouches: false,
                                    touchCallback: (FlTouchEvent event,
                                        LineTouchResponse? response) {
                                      // if (response == null || response.lineBarSpots == null) {
                                      //   return;
                                      // }
                                      // if (event is FlTapUpEvent) {
                                      //   final spotIndex =
                                      //       response.lineBarSpots!.first.spotIndex;
                                      //   showingTooltipOnSpots.clear();
                                      //   setState(() {
                                      //     showingTooltipOnSpots.add(spotIndex);
                                      //   });
                                      // }
                                    },
                                    mouseCursorResolver: (FlTouchEvent event,
                                        LineTouchResponse? response) {
                                      if (response == null ||
                                          response.lineBarSpots == null) {
                                        return SystemMouseCursors.basic;
                                      }
                                      return SystemMouseCursors.click;
                                    },
                                    getTouchedSpotIndicator:
                                        (LineChartBarData barData,
                                            List<int> spotIndexes) {
                                      return spotIndexes.map((index) {
                                        return TouchedSpotIndicatorData(
                                          FlLine(
                                            color: Colors.transparent,
                                          ),
                                          FlDotData(
                                            show: true,
                                            getDotPainter: (spot, percent,
                                                    barData, index) =>
                                                FlDotCirclePainter(
                                              radius: 3,
                                              color: Colors.white,
                                              strokeWidth: 3,
                                              strokeColor:
                                                  TColor.secondaryColor1,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    touchTooltipData: LineTouchTooltipData(
                                      tooltipRoundedRadius: 20,
                                      getTooltipItems:
                                          (List<LineBarSpot> lineBarsSpot) {
                                        return lineBarsSpot.map((lineBarSpot) {
                                          return LineTooltipItem(
                                            "${lineBarSpot.x.toInt()} mins ago",
                                            const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  lineBarsData: lineBarsData1,
                                  minY: -0.5,
                                  maxY: 110,
                                  titlesData: FlTitlesData(
                                      show: true,
                                      leftTitles: AxisTitles(),
                                      topTitles: AxisTitles(),
                                      bottomTitles: AxisTitles(
                                        sideTitles: bottomTitles,
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: rightTitles,
                                      )),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    horizontalInterval: 25,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: TColor.gray.withOpacity(0.15),
                                        strokeWidth: 2,
                                      );
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Find Something to Eat",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.55,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: findEatArr.length,
                          itemBuilder: (context, index) {
                            var fObj = yourfindEatArr[index] as Map? ?? {};
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MealFoodDetailsView(
                                              eObj: fObj,
                                              meal: widget.mealplan!,
                                              title: fObj['name'],
                                            )));
                              },
                              child: FindEatCell(
                                fObj: fObj,
                                index: index,
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                  ],
                ),
              ),
            );
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

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.primaryColor2,
          TColor.primaryColor1,
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: TColor.primaryColor2,
          ),
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 35),
          FlSpot(2, 70),
          FlSpot(3, 40),
          FlSpot(4, 80),
          FlSpot(5, 25),
          FlSpot(6, 70),
          FlSpot(7, 35),
        ],
      );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.gray,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
