import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toro_app/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  final String noText = '0575 - 511 213';
  final String addressText = 'Groenmarkt 37 7201 HW Zutphen';
  copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied: $text'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainAppColor,
        appBar: AppBar(
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.secondAppColor,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context); // Goes back to the last screen
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Image.asset(AppColors.logo, height: 300, ),

         
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(color: Colors.white, thickness: 1.5),
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 47),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'address'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        addressText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white, size: 34),
                    onPressed: () => copyText(context, addressText),
                    tooltip: 'Copy Address',
                  ),
                ],
              ),
            ),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(color: AppColors.secondAppColor, thickness: 1.5),
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.phone, color: Colors.white, size: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'number'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          noText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white, size: 34),
                    onPressed: () => copyText(context, noText),
                    tooltip: 'Copy Number',
                  ),
                ],
              ),
            ),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(color: Colors.white, thickness: 1.5),
              ),
            ),

            SizedBox(height: 25),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SocialMedia(
                  icon: Icons.language,
                  text: 'website'.tr(),
                  color: const Color.fromARGB(255, 15, 11, 11),
                  onTap: () {
                    _launchURL("https://restaurant-toro.nl/");
                  },
                ),

                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SocialMedia(
                    icon: Icons.facebook,
                    text: 'facebook'.tr(),
                    color: const Color(0xff1877F2),
                    onTap: () {
                      _launchURL(
                        "https://www.facebook.com/restauranttorozutphen/",
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                SocialMedia(
                  icon:
                      FontAwesomeIcons
                          .instagram, // if using font_awesome_flutter
                  text: 'Instagram'.tr(),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF833AB4), // Purple
                      Color(0xFFFD1D1D), // Red
                      Color(0xFFFCB045), // Orange
                    ],
                  ),
                  onTap: () {
                    _launchURL("https://www.instagram.com/restaurant_toro/");
                  },
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

class SocialMedia extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Gradient? gradient;
  final VoidCallback onTap;
  const SocialMedia({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.secondAppColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gradient != null
                ? ShaderMask(
                  shaderCallback: (bounds) => gradient!.createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Icon(icon, size: 35, color: Colors.white),
                )
                : Icon(icon, size: 35, color: color),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           
          ],
        ),
      ),
    );
  }
}
