import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/date_select_screen.dart';
import 'package:toro_app/screens/select_time_screen.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool showPersonsGrid = false;
  int itemCount = 20;
  bool showAdd = true;
  double aspectRatio = 2.1;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Book quickly and easily',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Make your reservation below for a pleasant afternoon or evening in our restaurant.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 370,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.secondAppColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //! person
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                showPersonsGrid = !showPersonsGrid;
                              });
                            },
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: Text(
                              'Persons',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          //! Calendar
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SelectDateScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: Text(
                              'Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          //! Time
                          // TextButton.icon(
                          //   onPressed: () {
                          //   },
                          //   icon: Icon(
                          //     Icons.access_time_outlined,
                          //     color: Colors.white,
                          //     size: 30,
                          //   ),
                          //   label: Text(
                          //     'Time',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),

              Visibility(
                visible: showPersonsGrid,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.users, color: Colors.white),
                          SizedBox(width: 18),
                          Text(
                            'How many guests?',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        itemCount: itemCount,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: aspectRatio,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: AppColors.secondAppColor.withOpacity(0.8),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: showAdd,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            itemCount = 40;
                            showAdd = false;
                            aspectRatio = 2;
                          });
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          size: 30,
                          color: AppColors.secondAppColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),
              SizedBox(
                height: 50,
                width: 370,
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.secondAppColor,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.search_sharp, color: Colors.white, size: 30),
                  label: Text(
                    'FIND A TABLE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
