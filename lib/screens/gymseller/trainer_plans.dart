import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:app/screens/gymseller/component/seller_card.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class Trainerplans extends StatefulWidget {
  Trainerplans({super.key});
  static String routeName = '/trainer';
  List<Map<String, dynamic>>? plans;
  Future<List<Map<String, dynamic>>?>? futureplan;
  @override
  State<Trainerplans> createState() => TrainerplansState();
}

class TrainerplansState extends State<Trainerplans> {
  Future<void> getdata() async {
    widget.futureplan = FirebaseCrud().getplans();
    widget.plans = await FirebaseCrud().getplans();
  }

  @override
  Widget build(BuildContext context) {
    getdata();

    return FutureBuilder(
        future: widget.futureplan,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.hasData) {
            var plan;
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
                  'Fittness Plans',
                  style: TextStyle(color: textcolorsecond),
                ),
              ),
              body: SafeArea(
                top: true,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    for (plan in widget.plans!) SellerCard(plandata: plan)
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
}
