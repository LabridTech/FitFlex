import 'dart:async';
import 'dart:developer';
import 'package:app/component/bottombar.dart';
import 'package:app/constant/color.dart';
import 'package:app/models/customermodal.dart';
import 'package:app/screens/errorpage/errorscreen.dart';
import 'package:app/screens/profilepage/component/accountcard.dart';
import 'package:app/screens/profilepage/component/status.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../firebase.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String routeName = '/profile';
  Future<Customer>? futureuser;
  bool? type;
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  Future<void> gettype() async {
    widget.type = await FirebaseCrud().gettrainertype();
  }

  Future<void> getdata() async {
    widget.futureuser = FirebaseCrud().readCustomer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    getdata();
    return FutureBuilder(
        future: widget.futureuser,
        builder: (BuildContext context, AsyncSnapshot<Customer> snapshot) {
          gettype();
          if (snapshot.hasData) {
            if (snapshot.data!.email == 'wrong password') {
              return ErrorScreen(
                errormsg: snapshot.data!.email,
              );
            }
            return Scaffold(
              bottomNavigationBar: Bottom(),
              backgroundColor: primary,
              appBar: AppBar(
                backgroundColor: primary,
                title: const Center(
                    child: Text(
                  'Profile',
                  style: TextStyle(color: textcolor),
                )),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(220, 224, 224, 224),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/F-avatar.png"),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                  fontSize: 18, color: textcolor),
                            ),
                            subtitle: const Text(
                              " Lose a Fat program",
                              style: TextStyle(fontSize: 9, color: textcolor),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [
                                    componentbackgroundcolor,
                                    Colors.blueAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            onPressed: () => {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: textcolor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    StatusCard(
                      age: snapshot.data!.age,
                      height: snapshot.data!.height,
                      weight: snapshot.data!.weight,
                    ),
                    AccountCard(
                      type: widget.type!,
                      customer: snapshot.data!,
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
}
