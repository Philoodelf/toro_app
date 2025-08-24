import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainAppColor,
        body: Column(
          children: [
            Image.asset(AppColors.logo),
            TextButton(
              onPressed: () {
                context.setLocale(const Locale('nl'));
              },
              child: Text('🇳🇱 Nederlands'),
            ),
            SizedBox(height: 16,),
            TextButton(
              onPressed: () {
                context.setLocale(const Locale('en'));
              },
              child: Text('🇬🇧 English'),
            ),
          ],
        ),
      ),
    );
  }
}
