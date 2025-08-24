import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('nl'), // Dutch
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('nl'),
      child: const MyApp(),
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // HomeScreen(),
    );
  }
}



