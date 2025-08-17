import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor:AppColors.mainAppColor),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // HomeScreen(),
    );
  }
}



