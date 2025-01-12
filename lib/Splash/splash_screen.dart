import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyan.shade50,
              Colors.lightGreen.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80), // Space from the top
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "images/Logo.png",
                      height: MediaQuery.of(context).size.height * 0.45,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.32, // Adjust vertical position for overlap
                    child: Text(
                      "Drive Safe",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade700,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.38, // Adjust for proper alignment
                    child: Text(
                      "Making roads a safer place",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.green.shade700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40), // Space before the buttons
              SizedBox(
                width: 300,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    print("Login button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    shadowColor: Colors.cyan.withOpacity(0.4),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Space between the buttons
              SizedBox(
                width: 300,
                height: 52,
                child: TextButton(
                  onPressed: () {
                    print("Sign up button pressed");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(
                      color: Colors.lightGreen.shade600,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
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
