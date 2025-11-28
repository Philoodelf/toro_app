import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/menu_screen.dart';
import 'package:toro_app/screens/reservation_screen.dart';
import 'package:toro_app/screens/socialmedia_screen.dart';
import 'package:toro_app/screens/wine_screen.dart';

import 'package:toro_app/widgets/costumemenu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainAppColor,
        body: Column(
          children: [
            Image.asset(AppColors.logo),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  children: [
                    CostumeMenu(
                      label: 'menu'.tr(),
                      icon: Icons.menu_book_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MenuScreen(),
                          ),
                        );
                      },
                    ),
                    CostumeMenu(
                      label: 'wine'.tr(),
                      icon: Icons.wine_bar_outlined,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WineScreen(),
                          ),
                        );
                      },
                    ),
                    CostumeMenu(
                      label: 'reservation'.tr(),
                      icon: Icons.calendar_month_outlined,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReservationScreen(),
                          ),
                        );
                      },
                    ),
                    CostumeMenu(
                      label: 'socialmedia'.tr(),
                      icon: Icons.numbers,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SocialMediaScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 25,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
