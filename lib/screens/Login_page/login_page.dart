import 'package:app/component/my_button_or%20sign_in%20button.dart';
import 'package:app/component/my_textfield.dart';
import 'package:app/component/square_tile%20or%20google%20and%20apple%20icon%20button.dart';
import 'package:app/firebase.dart';
import 'package:flutter/material.dart';
import 'package:app/constant/color.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  //final Function()? onTap;
  static String routeName = '/login';
  late String email;

  //LoginPage({super.key,required this.onTap});
  LoginPage({super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap your content with SingleChildScrollView
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                //const Icon(
                //  Icons.lock,
                //  size: 100,
                //),

                images(),
                const SizedBox(height: 50),
                // welcome back you have been missed
                const Text(
                  'Welcome back you have been missed',
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                //username textfield
                MytextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obsecureText: false,
                  prefix: const Icon(Icons.mail),
                ),

                const SizedBox(height: 10),
                // password textfield
                MytextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                  prefix: const Icon(Icons.lock),
                ),

                const SizedBox(height: 10),
                // forgot password
                const Text(
                  'Forgot your password?',
                  style: TextStyle(color: textcolor),
                ),

                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  text: 'Sign in',
                  onTap: () => {
                    FirebaseCrud().setSessionvariable(
                        usernameController.text, passwordController.text),
                    Navigator.pushNamed(context, '/profile'),
                  },
                ),

                const SizedBox(height: 50),
                // or continue with
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

                const SizedBox(height: 50),
                // google + apple sign in
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

                const SizedBox(height: 50),
                // not a member register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account yet?",
                      style: TextStyle(color: textcolor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(context, '/register'),
                      },
                      child: const Text(
                        'Register now',
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
