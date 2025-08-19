import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
                      SizedBox(
                        height: 260,
                        child: Image.asset(
                          'assets/images/about_us.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(seconds: 3),
                        curve: Curves.bounceIn,
                        left: 10,
                        right: 20,
                        bottom: showText ? 180 : -60,
                        child: Text(
                          'Experience the Mediterranean atmosphere',
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
                                'Our story',
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
                                "Located in the heart of Zutphen's vibrant city center, Restaurant Toro is a truly authentic Spanish-Argentine restaurant. With a view of the Wijnhuistoren (Wine House Tower), you'll feel like you're immersed in a Mediterranean atmosphere. Thanks to our friendly service and expert culinary skills, we've been awarded second place for the most fun and welcoming restaurant in Zutphen.",
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
                                "Our sunny terrace with plenty of shade also offers a wonderful spot for lunch, dinner or a nice drink in the summer months.",
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
