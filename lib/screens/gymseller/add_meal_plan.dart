import 'package:app/component/my_textfield.dart';
import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MakeMealPlan extends StatefulWidget {
  static String routeName = '/makemeal';

  final usernameController = TextEditingController();
  final plannameController = TextEditingController();
  final priceController = TextEditingController();

  MakeMealPlan({Key? key}) : super(key: key);

  @override
  _MakeMealPlanState createState() => _MakeMealPlanState();
}

class _MakeMealPlanState extends State<MakeMealPlan> {
  // Map to store meal categories and their respective foods
  final Map<String, List<String>> meals = {
    'Breakfast': ["Honey Pancake", "Canai Bread"],
    'Lunch': ["Blueberry Pancake"],
    'Dinner': ["Salmon Nigiri"],
  };

  // Map to store the switch states
  Map<String, bool> switchStates = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
  };

  // Map to store selected foods for each meal
  Map<String, List<String>> selectedFoods = {
    'Breakfast': [],
    'Lunch': [],
    'Dinner': [],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.restaurant_menu,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 40),
              Text(
                'Let\'s make a meal plan',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              SizedBox(height: 10),
              Text(
                'Choose the meal categories to make your plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Build the list of meal categories with toggle switches
              for (var category in meals.keys)
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
                            // Reset selected foods when switch is turned off
                            selectedFoods[category] = [];
                          }
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    if (switchStates[category] ?? false)
                      Column(
                        children: [
                          for (var food in meals[category]!)
                            CheckboxListTile(
                              title: Text(
                                food,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              value: selectedFoods[category]?.contains(food) ??
                                  false,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value ?? false) {
                                    // Add food to selected foods
                                    selectedFoods[category]?.add(food);
                                  } else {
                                    // Remove food from selected foods
                                    selectedFoods[category]?.remove(food);
                                  }
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.blue,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                        ],
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  print(selectedFoods);
                  print(switchStates);
                  FirebaseCrud().addmeal(
                      widget.usernameController.text,
                      widget.plannameController.text,
                      widget.priceController.text,
                      switchStates['Breakfast'] == true ? 'yes' : 'no',
                      switchStates['Lunch'] == true ? 'yes' : 'no',
                      switchStates['Dinner'] == true ? 'yes' : 'no',
                      selectedFoods['Breakfast'],
                      selectedFoods['Lunch'],
                      selectedFoods['Dinner']);
                  // Print selected foods for each meal (for demonstration)
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text(
                  'Create Meal Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 47, 151, 236),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
