import 'dart:developer';
import 'package:app/constant/color.dart';
import 'package:go_router/go_router.dart';

import '../../firebase.dart';
import 'package:flutter/material.dart';
import 'package:app/component/my_button_or%20sign_in%20button.dart';
import 'package:app/component/my_textfield.dart';
import 'package:app/component/square_tile%20or%20google%20and%20apple%20icon%20button.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //final Function()? onTap;
  //text editing controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isChecked = false;

  //sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap your content with SingleChildScrollView
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),

                  images(),

                  const SizedBox(height: 25),
                  // Create an account
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //first name textfield
                  MytextField(
                    controller: firstnameController,
                    hintText: 'Name',
                    obsecureText: false,
                    prefix: const Icon(Icons.person),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  //Last name textfield
                  MytextField(
                    controller: emailController,
                    hintText: 'Email',
                    obsecureText: false,
                    prefix: const Icon(Icons.mail),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  // email textfield
                  MytextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obsecureText: true,
                    prefix: const Icon(Icons.lock),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  // or continue with
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _isChecked = value;
                            });
                          }
                        },
                      ),
                      const Flexible(
                        child: Text(
                          'By continuing you accept our Privacy Policy and Terms of Use',
                          style: TextStyle(
                            color: textcolor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),
                  MyButton(
                    text: 'Register',
                    onTap: () => {
                      if (_formKey.currentState!.validate())
                        {
                          log(firstnameController.text),
                          FirebaseCrud().addUser(
                            firstnameController.text,
                            emailController.text,
                            passwordController.text,
                          ),
                        },
                      Navigator.pushNamed(context, '/profilecomplete',
                          arguments: emailController.text),
                    },
                  ),

                  const SizedBox(height: 25),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: textcolor),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google button
                      SquareTile(imagePath: '/images/Google.png'),
                      SizedBox(width: 20),
                      //apple button
                      SquareTile(imagePath: '/images/apple.png'),
                    ],
                  ),

                  const SizedBox(height: 25),
                  // not a member register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: textcolor),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

images() {
  return Image.asset(
    '/images/dumbbell.png',
    height: 100,
    width: 100,
  );
}
