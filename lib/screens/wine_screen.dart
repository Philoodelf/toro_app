import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/widgets/menu_card.dart';

class WineScreen extends StatefulWidget {
  const WineScreen({super.key});

  @override
  State<WineScreen> createState() => _WineScreenState();
}

class _WineScreenState extends State<WineScreen> {
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
                if (animationsFinished) {
                  Navigator.pop(context);
                }
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
                  child: AspectRatio(
                    aspectRatio:  16 / 9,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Image.asset(
                          'assets/images/partyimg.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ClipRect(
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 1700),
                                curve: Curves.bounceInOut,
                                alignment:
                                    showText
                                        ? const AlignmentDirectional(0, -0.95)
                                        : const AlignmentDirectional(0, 1.6),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: showText ? 1 : 0,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 160,
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        
                                        final scale = MediaQuery.textScalerOf(
                                          context,
                                        ).scale(1);
                    
                                        // لو اليوزر مكبّر قوي، ثبّت الخط عندك
                                        final fixedScale =
                                            scale > 1.1 ? 1.0 : scale;
                    
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaler: TextScaler.linear(
                                              fixedScale,
                                            ),
                                          ),
                                          child: Text(
                                            'winetitle'.tr(),
                                            softWrap: true,
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
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            'winesubtitle'.tr(),
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

                            //  SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'textrecommendation'.tr(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            Column(
                              children: [
                                recommendationItem(
                                  title: 'winerecommendation1'.tr(),
                                  price: '€34,50',
                                  description: 'winerecommendation1des'.tr(),
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
                                  title: 'winerecommendation2'.tr(),
                                  price: '€34,50',
                                  description: 'winerecommendation2des'.tr(),
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
                                  title: 'winerecommendation3'.tr(),
                                  price: '€34,50',
                                  description: 'winerecommendation3des'.tr(),
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
                                  title: 'winerecommendation4'.tr(),
                                  price: '€45,50',
                                  description: 'winerecommendation4des'.tr(),
                                ),
                                // SizedBox(
                                //   width: 360,
                                //   child: Divider(
                                //     color: const Color.fromARGB(
                                //       255,
                                //       164,
                                //       121,
                                //       59,
                                //     ),
                                //     thickness: 1,
                                //   ),
                                // ),
                                const SizedBox(height: 20),
                                // recommendationItem(
                                //   title: 'menurecommendation5'.tr(),
                                //   price: '€35.50',
                                //   description: 'menurecommendation5des'.tr(),
                                // ),
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
                                'downloadtextwine'.tr(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                            //?*! wine
                            Row(
                              children: [
                                //? first menu
                                SizedBox(
                                  height: 360,
                                  width:
                                      MediaQuery.of(context).size.width * 0.91,
                                  child: MenuCard(
                                    imagePath: 'assets/images/us.jpg',
                                    title: 'downloadwinelist'.tr(),
                                    description: 'winelist'.tr(),
                                    pdfUrl:
                                        'https://restaurant-toro.nl/nieuw/wp-content/uploads/2024/01/salentijn-wijnkaart-Binnen-2024.pdf',
                                  ),
                                ),
                                SizedBox(width: 10),

                                //? second menu
                                // MenuCard(
                                //   imagePath: 'assets/images/drinks.jpg',
                                //   title: 'drinkstitle'.tr(),
                                //   description: 'drinksmenu'.tr(),
                                //   pdfUrl:
                                //       'https://restaurant-toro.nl/nieuw/wp-content/uploads/2019/08/DIG-C-V4-Drankenborrelhapjes-kaart.pdf',
                                // ),
                                // SizedBox(width: 10),
                                // //? third menu
                                // MenuCard(
                                //   imagePath: 'assets/images/dessert.jpg',
                                //   title: 'desserttitle'.tr(),
                                //   description: 'dessertmenu'.tr(),
                                //   pdfUrl:
                                //       'https://restaurant-toro.nl/nieuw/wp-content/uploads/2019/08/DIG-C-V4-Menukaart-dessert-.pdf',
                                // ),
                              ],
                            ),
                            SizedBox(height: 12),
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(width: 10),
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
