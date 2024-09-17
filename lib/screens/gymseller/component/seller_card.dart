import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:app/screens/gymseller/workoutplan.dart';
import 'package:app/screens/profilepage/Trainer_Profile_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SellerCard extends StatefulWidget {
  SellerCard({super.key, required this.plandata});
  Map<String, dynamic> plandata;

  State<SellerCard> createState() => SellerCardState();
}

class SellerCardState extends State<SellerCard> {
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TrainerProfilePage.routeName, arguments: {
          'email': widget.plandata['email'],
          'name': widget.plandata['name']
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: textcolor,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 10, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://gravatar.com/avatar/70113892d75848d3f0b6ca931cb6637e?s=400&d=mp&r=x',
                        width: 74,
                        height: 77,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 70, 0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified_sharp,
                                color: Colors.deepPurple,
                                size: 24,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Container(
                                  width: 140,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0x4A57636C),
                                    borderRadius: BorderRadius.circular(10),
                                    shape: BoxShape.rectangle,
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    'Professional Trainer',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.deepPurple,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                iconSize: 40,
                                icon: Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.purple,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          Text(
                            widget.plandata['name'],
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            'Trainer',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: 2.75,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 10.0,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 17, 66, 129),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.plandata['exc_abs'] == 'yes'
                    ? Container(
                        margin:
                            const EdgeInsets.only(bottom: 10, top: 2, left: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.blueGrey])),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                          child: Text(
                            'Abs',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(),
                widget.plandata['exc_lower'] == 'yes'
                    ? Container(
                        margin:
                            const EdgeInsets.only(bottom: 10, top: 2, left: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.blueGrey])),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                          child: Text(
                            'Lower Body',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(),
                widget.plandata['exc_chest'] == 'yes'
                    ? Container(
                        margin:
                            const EdgeInsets.only(bottom: 10, top: 2, left: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.blueGrey])),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                          child: Text(
                            'Chest',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(120, 0, 120, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print("pressed");
                        Navigator.pushNamed(context, WorkoutPlan.routeName,
                            arguments: widget.plandata);
                      },
                      child: Text(
                        'Get Plan',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: primary,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
