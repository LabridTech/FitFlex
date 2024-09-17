import 'package:flutter/material.dart';
import '../constant/color.dart';

class StartScreen extends StatefulWidget {
  static String routeName = "/";
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Gives the width
    double height = MediaQuery.of(context).size.height; // Gives the height
    return Scaffold(
        backgroundColor: primary, // Set background color to black
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add your splash screen logo or image here (optional)
                  // For example:
                  // Image.asset('/images/app_logo.png'),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        'FitFlex',
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.white), // Adjust text style as needed
                      )),

                  const Text(
                    'Empower your body with our',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white), // Adjust text style as needed
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
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
                      Navigator.pushReplacementNamed(context,
                          '/login'); // Replace '/home' with your actual route name
                      //Navigator.pushNamed(context, '/profilecomplete',arguments: 'sasa');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ));
  }
}
