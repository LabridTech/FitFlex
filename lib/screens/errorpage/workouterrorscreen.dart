import 'package:app/screens/profilepage/profile.dart';
import 'package:flutter/material.dart';

class WorkoutErrorScreen extends StatelessWidget {
  WorkoutErrorScreen({super.key, required this.errormsg});
  String errormsg;
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Workout Error Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errormsg,
              style: const TextStyle(color: Colors.black),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, ProfileScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Back To Profile'))
          ],
        ),
      ),
    );
  }
}
