import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({super.key, required this.errormsg});
  String errormsg;
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Error Screen',
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
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Back To Login'))
          ],
        ),
      ),
    );
  }
}
