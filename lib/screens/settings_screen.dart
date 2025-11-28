import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/about_us_screen.dart';
import 'package:toro_app/screens/catering_screen.dart';
import 'package:toro_app/screens/contact_screen.dart';
import 'package:toro_app/screens/party_screen.dart';
import 'package:toro_app/screens/translation_screen.dart';
import 'package:toro_app/widgets/costumemenu.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainAppColor,

        body: Column(
          children: [
            Image.asset(AppColors.logo),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    children: [
                      CostumeMenu(
                        label: 'translation'.tr(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TranslationScreen(),
                            ),
                          );
                        },
                      ),
                      CostumeMenu(
                        label: 'party'.tr(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PartyScreen(),
                            ),
                          );
                        },
                      ),
                      CostumeMenu(
                        label: 'catering'.tr(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CateringScreen(),
                            ),
                          );
                        },
                      ),
                      CostumeMenu(
                        label: 'contact'.tr(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ContactScreen(),
                            ),
                          );
                        },
                      ),
                      CostumeMenu(
                        label: 'aboutus'.tr(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AboutUsScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 25,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
