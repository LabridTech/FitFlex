import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class StatusCard extends StatelessWidget {
  StatusCard(
      {super.key,
      required this.age,
      required this.height,
      required this.weight});

  int age;
  int height;
  int weight;
  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                GradientText(
                  '$height cm',
                  colors: [Colors.black, Colors.lightBlue],
                ),
                Text(
                  'Height',
                  style: TextStyle(color: Color.fromARGB(123, 27, 27, 27)),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                GradientText(
                  '$weight kg',
                  colors: [Colors.black, Colors.lightBlue],
                ),
                Text(
                  'Weight',
                  style: TextStyle(color: Color.fromARGB(123, 27, 27, 27)),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                GradientText(
                  '$age yo',
                  colors: [Colors.black, Colors.lightBlue],
                ),
                Text(
                  'Age',
                  style: TextStyle(color: Color.fromARGB(123, 27, 27, 27)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
