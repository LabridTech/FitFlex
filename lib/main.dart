import 'package:app/constant/color.dart';
import 'package:app/firebase_options.dart';
import 'package:app/screens/gymseller/make_plan_page.dart';
import 'package:app/screens/gymseller/trainer_plans.dart';
import 'package:app/screens/profilepage/profile.dart';
import 'package:app/screens/workout_tracker/workout_tracker_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'screens/startpage.dart';
import 'routes.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  bool check = false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool start = true;
  if (start) {
    start = false;
    if (await SessionManager().containsKey('email')) {
      await SessionManager().remove("email");
      await SessionManager().remove("password");
      await SessionManager().remove("trainer");
    }
  }
  if (await SessionManager().containsKey('email') == false) {
    check = true;
  }

  runApp(MyApp(check: check));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.check});
  bool check;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: primary,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
      initialRoute:
          check == true ? StartScreen.routeName : ProfileScreen.routeName, //

      routes: routes,
    );
  }
}
