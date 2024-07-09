import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to next page after the GIF has played once
    Future.delayed(const Duration(milliseconds: 6200), () {
      context.push('auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/svg/splash.gif', // Replace with your GIF file path
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ).animate(
          onComplete: (controller) {
            controller.stop();
          },
        ),
      ),
    );
  }
}
