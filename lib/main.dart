import 'package:flutter/material.dart';

import 'package:linebucks/game_home.dart';
import 'package:linebucks/help_screen.dart';
import 'package:linebucks/premium_screen.dart';
import 'package:linebucks/resumetracking_screen.dart';
import 'package:linebucks/startpage.dart';
import 'package:linebucks/utils/web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String check = await fetchButtonLinks('buttonlinks');
  if (check != "0") {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // fetchData();
    return MaterialApp(
      title: 'Taskline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 98, 42, 71),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      routes: {
        "/gamehome": (context) => const GameHome(),
        "/": (context) => const StartPg(),
        "/startpg": (context) => const StartPg(),
        "/premium": (context) => const PremiumScreen(),
        "/help": (context) => const HelpScreen(),
        "/tracking": (context) => const ResumeTrackingScreen(),
      },
    );
  }
}
