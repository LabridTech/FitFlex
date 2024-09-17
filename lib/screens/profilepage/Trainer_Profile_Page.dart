import 'package:app/firebase.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String label;

  StatCard({required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    );
  }
}

class WorkingHours extends StatelessWidget {
  final Map<String, String> workingHours;

  WorkingHours({required this.workingHours});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: workingHours.entries.map((entry) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.key, style: TextStyle(color: Colors.white)),
            Text(entry.value, style: TextStyle(color: Colors.white)),
          ],
        );
      }).toList(),
    );
  }
}

class TrainerProfilePage extends StatelessWidget {
  Future<Map<String, dynamic>?>? futureuser;
  static String routeName = '/detailstrainer';

  Future<void> getdata(email) async {
    futureuser = FirebaseCrud().readtrainer(email);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String email = args['email'].toString();
    String name = args['name'].toString();
    getdata(email);
    return FutureBuilder(
        future: futureuser,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text(
                  'Trainer Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                leading: BackButton(
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Implement share functionality
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      // Implement favorite functionality
                    },
                    color: Colors.white,
                  ),
                ],
                backgroundColor: Colors.black,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Trainer Information Section
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'images/dumbbell.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data!['Trainer Role'].toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  snapshot.data!['Location'].toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.white,
                        height: 1,
                        thickness: 1,
                      ),

                      const SizedBox(height: 30),
                      // Statistics Section
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatCard(
                                title: snapshot.data!['Trainees'].toString(),
                                label: 'Trainees'),
                            StatCard(
                                title: snapshot.data!['Experience'].toString(),
                                label: 'Years'),
                            StatCard(title: '4.6+', label: 'Rating'),
                            StatCard(title: '500+', label: 'Reviews'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // About Section
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${snapshot.data!['Trainer Name'].toString()} is a highly experienced and dedicated trainer with over ${snapshot.data!['Experience'].toString()} years of experience in the fitness industry. He has helped thousands of trainees achieve their fitness goals through his personalized training programs and motivational approach.',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Working Hours Section
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Working Hours',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            WorkingHours(
                                workingHours: snapshot.data!['WorkingHours']),
                          ],
                        ),
                      ),

                      // Book Appointment Button
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Book Appointment',
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
