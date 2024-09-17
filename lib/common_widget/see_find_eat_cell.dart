import 'package:app/common_widget/popular_meal_row.dart';

import '../../common_widget/round_button.dart';
import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class SeeFindEatCell extends StatelessWidget {
  final Map fObj;
  final int index;
  List sObj;
  SeeFindEatCell(
      {super.key, required this.index, required this.fObj, required this.sObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: media.width * 0.13, vertical: 20),
      width: media.width * 0.7,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEvent
                ? [
                    TColor.primaryColor2.withOpacity(0.5),
                    TColor.primaryColor1.withOpacity(0.5)
                  ]
                : [
                    TColor.secondaryColor2.withOpacity(0.5),
                    TColor.secondaryColor1.withOpacity(0.5)
                  ],
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(75),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                fObj["image"].toString(),
                width: media.width * 0.3,
                height: media.width * 0.25,
                fit: BoxFit.contain,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              fObj["name"],
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              fObj["number"],
              style: TextStyle(color: TColor.gray, fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                for (var ssobj in sObj)
                  PopularMealRow(
                    mObj: ssobj,
                    check: false,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
