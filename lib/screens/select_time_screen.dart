import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/reservation_screen.dart';

class SelectTimeScreen extends StatefulWidget {
  const SelectTimeScreen({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  List<DateTime> availableTimes = [];
  DateTime? selectedTime;

  @override
  void initState() {
    super.initState();
    _generateAvailableTimes();
  }

  void _generateAvailableTimes() {
    final start = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      11,
      0,
    );
    final end = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      21,
      30,
    );

    availableTimes = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      availableTimes.add(current);
      current = current.add(const Duration(minutes: 15));
    }

    setState(() {});
  }

  bool _isPastTime(DateTime time) {
    if (!isSameDay(time, DateTime.now())) return false;
    return time.isBefore(DateTime.now());
  }

  void _onSelectTime(DateTime time) {
    if (_isPastTime(time)) return; // Prevent selecting past times

    setState(() {
      selectedTime = time;
    });
    debugPrint(
      'Selected reservation time: ${DateFormat('HH:mm').format(time)}',
    );
  }

  void _confirmReservation() {
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time first!'.tr())),
      );
      return;
    }
    final formatted = DateFormat('HH:mm').format(selectedTime!);
    debugPrint('Reservation confirmed for: $formatted');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.secondAppColor,
        //! translation here too
        content: Text(
          'Reservation saved at $formatted'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
    Navigator.pop(context, selectedTime);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReservationScreen()));
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'At what time?'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                height: 430,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.5,
                            ),
                        itemCount: availableTimes.length,
                        itemBuilder: (context, index) {
                          final time = availableTimes[index];
                          final isPast = _isPastTime(time);
                          final isSelected = selectedTime == time;

                          return GestureDetector(
                            onTap: isPast ? null : () => _onSelectTime(time),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.secondAppColor
                                        : isPast
                                        ? Colors.grey.shade700
                                        : const Color.fromARGB(
                                          255,
                                          196,
                                          71,
                                          33,
                                        ).withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                DateFormat('HH:mm').format(time),
                                style: TextStyle(
                                  color:
                                      isPast
                                          ? Colors.grey.shade400
                                          : Colors.white,
                                  fontSize: 20,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _confirmReservation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondAppColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        'Confirm Time'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
