import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/screens/select_time_screen.dart';

class SelectDateScreen extends StatefulWidget {
  const SelectDateScreen({super.key});

  @override
  State<SelectDateScreen> createState() => _DateSelectState();
}

class _DateSelectState extends State<SelectDateScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final DateTime _firstDay = DateTime.now();
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 90));

  late final DateTime _firstAvailableDay;
  late final DateTime _lastAvailableDay;

  @override
  void initState() {
    super.initState();
    _firstAvailableDay = DateTime.now();
    _lastAvailableDay = DateTime(
      _firstAvailableDay.year,
      _firstAvailableDay.month + 3,
      _firstAvailableDay.day,
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      debugPrint(
        'Selected reservation date: ${DateFormat('yyyy-MM-dd').format(selectedDay)}',
      );
    }
  }

  void _saveReservation() {
    if (_selectedDay != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);
      debugPrint('Reservation saved for date: $formattedDate');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.secondAppColor,
          content: Text(
            'Date saved for $formattedDate',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectTimeScreen(
                            selectedDate: _selectedDay!,
                          ),
                        ),
                      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          content: const Text(
            'Please select a date first!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month_outlined, color: Colors.white, size: 40,),
                          SizedBox(width: 10),
                          Text(
                            'For what day?',
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
            const SizedBox(height: 28),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.brown.shade800.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                firstDay: _firstAvailableDay,
                lastDay: _lastAvailableDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.secondAppColor,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.secondAppColor,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade900.withOpacity(0.7),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                daysOfWeekHeight: 40,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: AppColors.secondAppColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  weekdayStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),

                calendarStyle: CalendarStyle(
                  cellMargin: const EdgeInsets.all(6),
                  cellPadding: const EdgeInsets.all(8),
                  weekendTextStyle: const TextStyle(
                    color: AppColors.secondAppColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.secondAppColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.secondAppColor,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  disabledTextStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
           // const Spacer(),
           const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: _saveReservation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondAppColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                label: const Text(
                  'Confirm Date',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
