import 'package:app/component/my_textfield.dart';
import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:flutter/material.dart';

class MakePlan extends StatefulWidget {
  MakePlan({Key? key}) : super(key: key);
  static String routeName = '/makeplan';

  final usernameController = TextEditingController();
  final plannameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  _MakePlanState createState() => _MakePlanState();
}

class _MakePlanState extends State<MakePlan> {
  // Map to store workout categories and their respective exercises
  final Map<String, List<String>> workouts = {
    'Abs': ["Warm Up", "Rest and Drink", "Jumping Jack"],
    'Lower Body': ["Arm Raises", "Rest and Drink", "Skipping"],
    'Chest': ["Squats", "Rest and Drink", "Skipping"],
  };

  // Map to store the switch states
  Map<String, bool> switchStates = {
    'Abs': false,
    'Lower Body': false,
    'Chest': false,
  };

  // Map to store selected exercises for each category
  Map<String, List<String>> selectedExercises = {
    'Abs': [],
    'Lower Body': [],
    'Chest': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Icon(
                    Icons.fitness_center,
                    size: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Let\'s make a fitness plan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choose the workout categories to make your plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  MytextField(
                    controller: widget.usernameController,
                    hintText: 'Username',
                    obsecureText: false,
                    prefix: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 10),
                  MytextField(
                    controller: widget.plannameController,
                    hintText: 'Planname',
                    obsecureText: false,
                    prefix: const Icon(Icons.branding_watermark),
                  ),
                  const SizedBox(height: 10),
                  MytextField(
                    controller: widget.priceController,
                    hintText: 'Price',
                    obsecureText: false,
                    prefix: const Icon(Icons.price_change),
                  ),
                  const SizedBox(height: 10),
                  // Build the list of workout categories with toggle switches
                  for (var category in workouts.keys)
                    Column(
                      children: [
                        SwitchListTile(
                          title: Text(
                            category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          value: switchStates[category] ?? false,
                          onChanged: (bool value) {
                            setState(() {
                              switchStates[category] = value;
                              if (!value) {
                                // Reset selected exercises when switch is turned off
                                selectedExercises[category] = [];
                              }
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        if (switchStates[category] ?? false)
                          Column(
                            children: [
                              for (var exercise in workouts[category]!)
                                CheckboxListTile(
                                  title: Text(
                                    exercise,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: selectedExercises[category]
                                          ?.contains(exercise) ??
                                      false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value ?? false) {
                                        // Add exercise to selected exercises
                                        selectedExercises[category]
                                            ?.add(exercise);
                                      } else {
                                        // Remove exercise from selected exercises
                                        selectedExercises[category]
                                            ?.remove(exercise);
                                      }
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                            ],
                          ),
                        SizedBox(height: 20),
                      ],
                    ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Print selected exercises for each category (for demonstration)
                      FirebaseCrud().addplan(
                          widget.usernameController.text,
                          widget.plannameController.text,
                          widget.priceController.text,
                          switchStates['Abs'] == true ? 'yes' : 'no',
                          switchStates['Chest'] == true ? 'yes' : 'no',
                          switchStates['Lower Body'] == true ? 'yes' : 'no',
                          selectedExercises['Abs'],
                          selectedExercises['Chest'],
                          selectedExercises['Lower Body']);
                      // Print selected foods for each meal (for demonstration)
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Text(
                      'Create Workout Plan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 47, 151, 236),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
