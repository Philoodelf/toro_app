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
            padding: const EdgeInsets.all(8.0),
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
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //?facebook
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL(
                          'https://www.facebook.com/restauranttorozutphen/',
                        );
                      },
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // for rounded ripple
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.facebook,
                            color: Color(0xff1877F2),
                            size: 75,
                          ),
                          Text(
                            'Facebook',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 25),
                //?instagram
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL('https://www.instagram.com/restaurant_toro/');
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xFF833AB4), // Purple
                              Color(0xFFFD1D1D), // Red
                              Color(0xFFFCB045), // Orange
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(FontAwesomeIcons.instagram, size: 75),
                            Text(
                              'Instagram',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 300, child: Divider(color: AppColors.secondAppColor, thickness: 1)),
            //? copy address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.secondAppColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                    
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                     // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            addressText,
                            style: const TextStyle(color: AppColors.mainAppColor, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 8),
                    
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () => copyText(context, addressText),
                          tooltip: 'Copy Address',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //? copy number
           Padding(
             padding: const EdgeInsets.only(left: 8,right: 170, top: 8, ),
             child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.secondAppColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                   
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                     // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            noText,
                            style: const TextStyle(color: AppColors.mainAppColor, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 8),
                   
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () => copyText(context, noText),
                          tooltip: 'Copy Number',
                        ),
                        
                      ],
                    ),
                  ),
                  
                ],
              ),
           ),
      
            // Row(
            //   children: [
            //     Text('0575 - 511 213'),
            //     IconButton(
            //       icon: const Icon(Icons.copy),
            //       onPressed: () => copyText(context, noText),
            //       tooltip: 'Copy',
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
