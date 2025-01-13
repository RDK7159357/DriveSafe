import 'package:flutter/material.dart';
import 'Splash/splash_screen.dart';
import 'Sign_up/sign_up_screen.dart';
import 'Login/login_screen.dart';
import 'Home/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive Safe',
      routes: {
        "/splash_screen":(context)=>SplashScreen(),
        "/sign_up_screen":(context)=>SignUpScreen(),
        "/login_screen":(context)=>LoginScreen(),
        "/home_screen":(context)=>HomeScreen(),
      },
      initialRoute: "/splash_screen",
      debugShowCheckedModeBanner: false,
  
    );
  }
}

