import 'package:app/component/my_button_or%20sign_in%20button.dart';
import 'package:app/component/my_textfield.dart';
import 'package:app/constant/color.dart';
import 'package:app/firebase.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/widgets.dart';

class CompleteProfile extends StatefulWidget {
  static String routeName = '/profilecomplete';

  @override
  _CompleteProfile createState() => _CompleteProfile();
}

class _CompleteProfile extends State<CompleteProfile> {
  String? _selectedGender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //text editing controller
  final dobController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    //print(ModalRoute.of(context)!.settings);
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  images(),
                  const SizedBox(height: 50),
                  const Text(
                    'Let\'s complete your profile',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'It will help us to know more about you!',
                    style: TextStyle(color: textcolor),
                  ),
                  const SizedBox(height: 25),
                  // Gender dropdown menu
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: textcolor,
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          hintText: 'Choose Gender',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          hintStyle: TextStyle(color: Colors.grey)),
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Date of Birth textfield
                  MytextField(
                    controller: dobController,
                    hintText: 'Age',
                    obsecureText: false,
                    prefix: Icon(Icons.calendar_today),
                    validator: (value) {
                      // You can add validation logic for date of birth
                      return null; // Return error message if validation fails
                    },
                  ),
                  const SizedBox(height: 10),
                  // Weight textfield
                  MytextField(
                    controller: weightController,
                    hintText: 'Your Weight',
                    obsecureText: false,
                    prefix: Icon(Icons.fitness_center),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // height textfield
                  MytextField(
                    controller: heightController,
                    hintText: 'Your Height',
                    obsecureText: false,
                    prefix: Icon(Icons.height),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Please enter a valid height';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  // sign in button
                  MyButton(
                    text: 'Next',
                    onTap: () => {
                      if (_formKey.currentState!.validate())
                        {
                          FirebaseCrud().updateCustomer(
                              email,
                              dobController.text,
                              weightController.text,
                              heightController.text,
                              _selectedGender!),
                          Navigator.pushNamed(context, '/profile',
                              arguments: email),
                        }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget images() {
  return Image.asset(
    '/images/dumbbell.png',
    height: 200,
    width: 200,
  );
}
