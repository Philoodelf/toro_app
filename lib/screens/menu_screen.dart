import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/widgets/menu_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //

  bool showText = false;
  bool visible = false;
  bool appear = false;
  bool div = false;
  bool animationsFinished = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2), () {
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
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/party.jpg', fit: BoxFit.cover),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.bounceIn,
                        left: 10,
                        right: 20,
                        bottom: showText ? 160 : -70,
                        child: Text(
                          'partytitle'.tr(),
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
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: visible ? 1.0 : 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'partysubtitle'.tr(),
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
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'recommendations'.tr(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 18),

                            Column(
                              children: [
                                recommendationItem(
                                  title: 'Sea bream fries',
                                  price: '€31.50',
                                  description:
                                      'Fried sea bream with lemon, garlic and tomato',
                                ),
                                SizedBox(
                                  width: 360,
                                  child: Divider(
                                    color: const Color.fromARGB(
                                      255,
                                      164,
                                      121,
                                      59,
                                    ),
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                recommendationItem(
                                  title: 'Sorpresa de gamba\'s envuelto',
                                  price: '€34.50',
                                  description:
                                      'Surprise of prawns rolled in veal with cream sauce',
                                ),
                                SizedBox(
                                  width: 360,
                                  child: Divider(
                                    color: const Color.fromARGB(
                                      255,
                                      164,
                                      121,
                                      59,
                                    ),
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                recommendationItem(
                                  title: 'Cordero con higos',
                                  price: '€32.50',
                                  description: 'Lamb with plums and sesame',
                                ),
                                SizedBox(
                                  width: 360,
                                  child: Divider(
                                    color: const Color.fromARGB(
                                      255,
                                      164,
                                      121,
                                      59,
                                    ),
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                recommendationItem(
                                  title: 'Chuleton',
                                  price: '€39.50',
                                  description:
                                      'Dry aged Rib Eye with herb butter and vegetable skewers',
                                ),
                                SizedBox(
                                  width: 360,
                                  child: Divider(
                                    color: const Color.fromARGB(
                                      255,
                                      164,
                                      121,
                                      59,
                                    ),
                                    thickness: 1,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                recommendationItem(
                                  title: 'Filete con Chimichurri',
                                  price: '€35.50',
                                  description: 'Steak with Chimichurri Sauce',
                                ),
                              ],
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: Divider(
                                  color: AppColors.secondAppColor,
                                  thickness: 1,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Download onze kaarten',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                            //?*! Menu
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //? first menu
                                  MenuCard(
                                    imagePath: 'assets/images/party.jpg',
                                    title: 'Dessert',
                                    description:
                                        'Finish your dinner with one of our delicious desserts or a special coffee.',
                                    pdfUrl:
                                        'https://restaurant-toro.nl/nieuw/wp-content/uploads/2019/08/DIG-C-V4-Menukaart-dessert-.pdf',
                                  ),
                                
                                  //? second menu
                                   MenuCard(
                                    imagePath: 'assets/images/party.jpg',
                                    title: 'Drinks',
                                    description:
                                        'Finish your dinner with one of our delicious desserts or a special coffee.',
                                    pdfUrl:
                                        'https://restaurant-toro.nl/nieuw/wp-content/uploads/2019/08/DIG-C-V4-Drankenborrelhapjes-kaart.pdf',
                                  ),
                                  //? third menu
                                   MenuCard(
                                    imagePath: 'assets/images/party.jpg',
                                    title: 'Launch and Dinner',
                                    description:
                                        'Finish your dinner with one of our delicious desserts or a special coffee.',
                                    pdfUrl:
                                        'https://restaurant-toro.nl/nieuw/wp-content/uploads/2019/08/DIG-C-Toro-Menukaart-Map-Lunchdiner-V5.pdf',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recommendationItem({
    required String title,
    required String price,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),

              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondAppColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
