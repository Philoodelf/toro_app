import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/socialmedia_screen.dart';

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
            Image.asset('assets/images/logo_app.png'),
            Container(
              child: Column(
                spacing: 12,
                children: [
                  CostumeMenu(
                    label: 'Menu',
                    icon: Icons.menu_book_rounded,
                    onTap: () {},
                  ),
                  CostumeMenu(
                    label: 'Reservation',
                    icon: Icons.calendar_today_outlined,
                    onTap: () {},
                  ),
                  CostumeMenu(
                    label: 'Social Media',
                    icon: Icons.numbers,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SocialMediaScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
