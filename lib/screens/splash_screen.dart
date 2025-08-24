import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/widgets/button_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 1.0;
  Offset _offset = const Offset(0, -2); // Start above the screen

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _offset = Offset.zero;
      });

      Future.delayed(const Duration(milliseconds: 1200), () {
        setState(() {
          _scale = 1.4;
        });
      });
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ButtonNav()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      body: Center(
        child: AnimatedSlide(
          offset: _offset,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.elasticOut,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: Image.asset(AppColors.logo),
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:toro_app/const/colors.dart';

// import 'package:toro_app/widgets/button_nav.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(
//         context,
//       ).pushReplacement(MaterialPageRoute(builder: (context) => ButtonNav()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainAppColor,
//       body: Center(child: Image.asset('assets/images/logo.png')),
//     );
//   }
// }  
