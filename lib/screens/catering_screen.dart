import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';

class CateringScreen extends StatefulWidget {
  const CateringScreen({super.key});

  @override
  State<CateringScreen> createState() => _CateringScreenState();
}

class _CateringScreenState extends State<CateringScreen> {
  bool showText = false;
  bool visible = false;
  bool appear = false;
  bool div = false;
  bool animationsFinished = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        showText = true;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        visible = true;
      });
    });

    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        div = true;
      });
    });

    Future.delayed(Duration(seconds: 9), () {
      setState(() {
        appear = true;
        animationsFinished=true;
      });
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
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/catering.jpg',
                        fit: BoxFit.cover,
                      ),
                      AnimatedPositioned(
                        duration: Duration(seconds: 3),
                        curve: Curves.bounceIn,
                        left: 10,
                        right: 20,
                        bottom: showText ? 160 : -70,
                        child: Text(
                          'Surprise your visitors with our kitchen',
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

                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSlide(
                      offset:
                          visible
                              ? Offset.zero
                              : const Offset(-1.5, 0), // start from left
                      duration: const Duration(seconds: 4),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: visible ? 1.0 : 0.0,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Spanish-Argentine restaurant Toro is also the perfect place for catering. Whether you have a group of 10 or a large party of 1000, we can arrange it for you.',
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
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOut,
                      width: div ? 300 : 0, // animate width
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
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Catering',
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
                                "Are you planning a party or gathering? And is catering just the thing you're struggling with? We can take care of it for you. Together, we'll create the menu and discuss your preferences. We offer a wide range of options, including vegetarian, fully organic, and slow-cooked options. Even if you have a specific theme in mind, we'll tailor the dishes to your needs.",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Our chefs will create the appropriate dishes for every occasion and in combination with the wines from our menu the experience will be complete.",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
