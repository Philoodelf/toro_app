import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/home_screen.dart';
import 'package:toro_app/screens/settings_screen.dart';
import 'package:toro_app/widgets/button_nav.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainAppColor,
        appBar: AppBar(
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.secondAppColor,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppColors.logo),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppColors.secondAppColor,
                  ),
                  fixedSize: WidgetStatePropertyAll<Size>(Size(244, 50)),
                ),
                onPressed: () {
                  context.setLocale(const Locale('nl'));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ButtonNav()),
                  );
                },
                child: Text(
                  '🇳🇱 Nederlands',
                  style: TextStyle(fontSize: 25, color: AppColors.mainAppColor),
                ),
              ),
          
              SizedBox(height: 25),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppColors.secondAppColor,
                  ),
                  fixedSize: WidgetStatePropertyAll<Size>(Size(244, 50)),
                ),
                onPressed: () {
                  context.setLocale(const Locale('de'));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ButtonNav()),
                  );
                },
                child: Text(
                  '🇩🇪 Deutsch',
                  style: TextStyle(fontSize: 25, color: AppColors.mainAppColor),
                ),
              ),
              SizedBox(height: 25),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppColors.secondAppColor,
                  ),
                  fixedSize: WidgetStatePropertyAll<Size>(Size(244, 50)),
                ),
                onPressed: () {
                  context.setLocale(const Locale('en'));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ButtonNav()),
                  );
                },
                child: Text(
                  '🇬🇧 English',
                  style: TextStyle(fontSize: 25, color: AppColors.mainAppColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
