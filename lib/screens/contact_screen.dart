import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toro_app/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool showText = false;
  bool visible = false;
  bool appear = false;
  bool div = false;
  bool animationsFinished = false;
  final String addressText = 'Groenmarkt 37 7201 HW Zutphen';
  final String noText = '0575 - 511 213';
  final String emailText = 'info@restaurant-toro.nl';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        showText = true;
      });
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        visible = true;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        div = true;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        appear = true;
        animationsFinished = true;
      });
    });
  }

  copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('copied', args: [text])),
          //Text('copied: $text'),
          duration: Duration(seconds: 2),
        ),
      );
    });
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
                if (animationsFinished) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 250,
                    child: GestureDetector(
                      onTap: () async {
                        const url =
                            'https://www.google.com/maps/search/?api=1&query=Groenmarkt+37+7201+HW+Zutphen';
                        debugPrint('Trying to open: $url');
                        await _launchURL(url);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/contact.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                            // height: double.infinity,
                          ),
                          SizedBox(
                            height: 250,
                            child: Container(
                              decoration: BoxDecoration(
                                //  borderRadius: BorderRadius.circular(16),
                                color: Colors.black.withOpacity(
                                  0.2,
                                ), // adjust opacity
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: Duration(seconds: 2),
                            curve: Curves.bounceIn,
                            left: 10,
                            right: 20,
                            bottom: showText ? 160 : -70,
                            child: Text(
                              'contacttitle'.tr(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 6,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSlide(
                      offset:
                          visible
                              ? Offset.zero
                              : const Offset(-1.5, 0), // start from left
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: visible ? 1.0 : 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'contactsubtitle'.tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      width:
                          div
                              ? MediaQuery.of(context).size.width * 0.8
                              : 0, // animate width
                      child: Divider(
                        color: AppColors.secondAppColor,
                        thickness: 1,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: appear ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: AnimatedSlide(
                        offset: appear ? Offset.zero : const Offset(0, 0.2),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'contacttext'.tr(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "contactsubtext".tr(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Our dishes can be paired with delicious Spanish and Argentinian wines, and combined with our Mediterranean atmosphere, it's sure to be a success. Curious about the possibilities? Feel free to contact us or simply drop by and experience the atmosphere.",
                            //     style: TextStyle(
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.w600,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            //  SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
                    //const SizedBox(height: 18),
                  ],
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.8, // animate width
                  child: Divider(color: AppColors.secondAppColor, thickness: 1),
                ),
                //? contact info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      //? location
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.secondAppColor,
                            size: 35,
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  addressText,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                onPressed: () => copyText(context, addressText),
                                tooltip: 'Copy Address',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      //? phone
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.secondAppColor,
                            size: 35,
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  noText,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                onPressed: () => copyText(context, noText),
                                tooltip: 'Copy Phone',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      //? email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            color: AppColors.secondAppColor,
                            size: 35,
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  emailText,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                onPressed: () => copyText(context, emailText),
                                tooltip: 'Copy Email',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
