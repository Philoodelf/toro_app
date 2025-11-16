import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/date_select_screen.dart';
import 'package:toro_app/screens/reservation_details_screen.dart';
import 'package:toro_app/widgets/button_nav.dart';

//! restaurant’s UUID
//! offerUuid
//! dol hathom 34an required w ht4t8l m3ak fe postman

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime? _selectedDate;
  DateTime? _selectedTime;

  int? _selectedGuests;
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ButtonNav()),
                  (Route<dynamic> route) => false,
                ); // Goes back to the last screen
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
                  'booktitle'.tr(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'reservationtitle'.tr(),
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
                              'persontext'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          //! Calendar
                          TextButton.icon(
                            onPressed: () async {
                              // Wait for the result returned from SelectDateScreen
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const SelectDateScreen(),
                                ),
                              );

                              if (result != null && mounted) {
                                setState(() {
                                  _selectedDate = result['date'];
                                  _selectedTime = result['time'];
                                });
                              }
                            },
                            //  {
                            //   Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //       builder: (context) => SelectDateScreen(),
                            //     ),
                            //   );
                            // },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: Text(
                              'datetext'.tr(),
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
              if (_selectedDate != null && _selectedTime != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    '${'selectedtext'.tr()}: ${_selectedDate != null ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}' : ''} ${'at'.tr()} ${_selectedTime != null ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}' : ''}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                'findtable'.tr(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),

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
                            'guestsno'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                          final int number = index + 1;
                          final bool isSelected = _selectedGuests == number;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGuests = number;
                              });
                              debugPrint('Selected guests: $_selectedGuests');
                            },
                            child: Card(
                              color:
                                  isSelected
                                      ? Colors
                                          .white // highlight background
                                      : AppColors.secondAppColor.withOpacity(
                                        0.8,
                                      ),
                              elevation: isSelected ? 6 : 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$number',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? AppColors.secondAppColor
                                            : Colors.white,
                                  ),
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
                height: 60,
                width: 370,
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.secondAppColor,
                    ),
                  ),
                  onPressed: () {
                    if (_selectedGuests == null ||
                        _selectedDate == null ||
                        _selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('snackbardate').tr()),
                      );
                    } else {
                      //? Continue to next step (e.g., send reservation to API)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => ReservationDetailsScreen(
                                selectedDate: _selectedDate!,
                                selectedTime: _selectedTime!,
                                selectedGuests: _selectedGuests!,
                              ),
                        ),
                      );
                      debugPrint('Guests: $_selectedGuests');
                      debugPrint('Date: $_selectedDate');
                      debugPrint('Time: $_selectedTime');
                    }
                  },
                  icon: Icon(Icons.search_sharp, color: Colors.white, size: 30),
                  label: Text(
                    'findtable'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
