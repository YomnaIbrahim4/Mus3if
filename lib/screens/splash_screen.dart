import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _heartbeatController;
  late Animation<double> _heartbeatAnimation;
  @override
  void initState() {
    super.initState();

    _heartbeatController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),);

      _heartbeatAnimation= Tween<double>(
        begin: 1.0,
        end: 1.5,
      ).animate(CurvedAnimation(
        parent: _heartbeatController,
        curve: Curves.elasticOut,),);
        _heartbeatController.repeat(reverse: true);

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
          ),
          );
    });
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Lottie.asset(
          'assets/animation/heartbeat _line.json',
          width: 400,
          height: 400,
          repeat: true,
          animate: true,
        ),
        SizedBox(height: 15,),
        AnimatedBuilder(
          animation: _heartbeatAnimation,
          builder: (context, child){
            return Transform.scale(
              scale: _heartbeatAnimation.value,
              child: Text('Mus3if',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color(0xffFF0000),
          ),
          ),
            );
          },
        ),
        SizedBox(height: 40,),
        Text('Your Guide to Emergency Care',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            ),
          ],
        ),
      ),
    );
  }
}