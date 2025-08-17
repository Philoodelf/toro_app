import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
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
            Image.asset('assets/images/logo.png'),
            Container(
              child: Center(
                child: SizedBox(height: 260,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 12,
                      children: [
                        CostumeMenu(label: 'Party', onTap: () {}),
                        CostumeMenu(label: 'Catering', onTap: () {}),
                        CostumeMenu(label: 'Contact', onTap: () {}),
                        CostumeMenu(label: 'About us', onTap: () {}),
                        CostumeMenu(label: 'Translation', onTap: () {}),
                        
                      ],
                    ),
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
