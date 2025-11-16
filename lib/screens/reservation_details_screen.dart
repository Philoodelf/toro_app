import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toro_app/const/colors.dart';
import 'package:toro_app/widgets/button_nav.dart';
import 'package:toro_app/widgets/custom_textfield.dart';
import 'package:toro_app/widgets/titles_constants.dart';

class ReservationDetailsScreen extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime selectedTime;
  final int selectedGuests;

  const ReservationDetailsScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedGuests,
  });

  @override
  State<ReservationDetailsScreen> createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  String? _selectedOption;
  String? _selectedDropdownValue;

  // final List<String> dropdownItems = [
  //   'Mr. and Mrs',
  //   'Doctor',
  //   'Professor',
  //   'Counsel',
  //   'Ambassador',
  //   'Madam Ambassador',
  //   'President',
  //   'Madam President',
  //   'Magister',
  //   'Chef',
  //   'Prince',
  //   'Princess',
  //   'Count',
  //   'Countess',
  //   'Duke',
  //   'Duchess',
  //   'Sir',
  //   'Lord',
  //   'Lady',
  //   'His/Her Royal Highness',
  //   'Baron',
  //   'Baroness',
  //   'Company',
  // ];
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
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Reservation Details'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.secondAppColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondAppColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const Text(
                        //   'Reservation Details',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 26,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        //  const SizedBox(height: 20),
                        _buildDetailRow(
                          icon: Icons.people,
                          label: 'Guests:'.tr(),
                          value: '${widget.selectedGuests}',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.calendar_month_outlined,
                          label: 'Date:'.tr(),
                          value:
                              '${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.access_time,
                          label: 'Time:'.tr(),
                          value:
                              '${widget.selectedTime.hour.toString().padLeft(2, '0')}:${widget.selectedTime.minute.toString().padLeft(2, '0')}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              _buildRadioSection(),

              SizedBox(height: 42),
              SizedBox(
                width: 300,
                child: Divider(color: AppColors.secondAppColor, thickness: 1),
              ),
              SizedBox(height: 18),
              Text(
                'Please Enter your info'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CustomTextfield(
                selectedGuests: widget.selectedGuests,
                selectedDate: widget.selectedDate,
                selectedTime: TimeOfDay.fromDateTime(widget.selectedTime),
                selectedTitle: _selectedOption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRadioOption('Mr.'.tr()),
          _buildRadioOption('Ms.'.tr()),
          _buildRadioOption('Mx.'.tr()),
          _buildRadioOption('Other'.tr(), hasDropdown: true),
          if (_selectedOption == 'Other'.tr())
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 12, right: 12),
              child: DropdownButtonFormField<String>(
                dropdownColor: AppColors.mainAppColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.secondAppColor.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.secondAppColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.secondAppColor,
                      width: 2,
                    ),
                  ),
                ),
                value: _selectedDropdownValue,
                items:
                    TitlesConstants.dropdownItems
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDropdownValue = value;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String value, {bool hasDropdown = false}) {
    return RadioListTile<String>(
      activeColor: AppColors.secondAppColor,
      title: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      value: value,
      groupValue: _selectedOption,
      onChanged: (val) {
        setState(() {
          _selectedOption = val;
          if (val != 'Other'.tr()) _selectedDropdownValue = null;
        });
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -4),
      visualDensity: const VisualDensity(
        horizontal: -4,
        vertical: -4,
      ), // tighter spacing
      dense: true,
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.secondAppColor, size: 28),
        const SizedBox(width: 12),
        Text(
          '$label ',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
