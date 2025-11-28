import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toro_app/const/colors.dart';

class CustomTextfield extends StatefulWidget {
  final int selectedGuests;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String? selectedTitle;
  final String? selectedDropdownValue;
  const CustomTextfield({
    super.key,
    required this.selectedGuests,
    required this.selectedDate,
    required this.selectedTime,
    this.selectedTitle,
    this.selectedDropdownValue,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otherTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLabeledField(
              label: 'First Name *'.tr(),
              controller: _firstNameController,
              validator:
                  (value) =>
                      value!.isEmpty
                          ? 'Please enter your first name'.tr()
                          : null,
            ),
            const SizedBox(height: 12),
            _buildLabeledField(
              label: 'Last Name *'.tr(),
              controller: _lastNameController,
              validator:
                  (value) =>
                      value!.isEmpty
                          ? 'Please enter your last name'.tr()
                          : null,
            ),
            const SizedBox(height: 12),
            _buildLabeledField(
              label: 'Email *'.tr(),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email'.tr();
                }

                // Basic email validation using RegExp
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address'.tr();
                }

                return null; // ✅ valid email
              },
            ),
            const SizedBox(height: 12),
            //? intl phone field
            _buildPhoneField(),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondAppColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              onPressed: () async {
                final isValid = _formKey.currentState?.validate() ?? false;

                if (isValid) {
                  final dio = Dio(
                    BaseOptions(
                      connectTimeout: Duration(seconds: 30),
                      receiveTimeout: Duration(seconds: 20),
                      followRedirects: true,
                      maxRedirects: 5,
                      validateStatus: (s) => s != null && s < 500,
                    ),
                  );

                  // Replace with your actual backend URL (e.g. your server IP)
                  const apiUrl =
                      'https://flutter-mail-backend-production.up.railway.app/api/email';

                  final reservationData = {
                    "firstName": _firstNameController.text,
                    "lastName": _lastNameController.text,
                    "receiverEmail": _emailController.text,
                    "phone": _phoneController.text,
                    "guests": widget.selectedGuests.toString(),
                    "date":
                        "${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
                    "time":
                        "${widget.selectedTime.hour.toString().padLeft(2, '0')}:${widget.selectedTime.minute.toString().padLeft(2, '0')}",
                    // "title":
                    //     widget.selectedTitle == 'Other'.tr()
                    //  ? widget.selectedDropdownValue.toString() ?? ""
                    //  : widget.selectedTitle.toString(),
                    "title":
                        (widget.selectedDropdownValue != null &&
                                widget.selectedDropdownValue!.trim().isNotEmpty)
                            ? widget.selectedDropdownValue!
                                .trim() // use dropdown if filled
                            : (widget.selectedTitle ?? '')
                                .trim(), // otherwise use radio title
                  };

                  try {
                    final response = await dio.post(
                      apiUrl,

                      data: reservationData,
                      options: Options(
                        headers: {'Content-Type': 'application/json'},
                      ),
                    );
                    print('Status code: ${response.statusCode}');
                    print('Response data: ${response.data}');

                    if (response.data['success'] == true) {
                      _showSuccessDialog(context, reservationData);
                    } else {
                      final errorMsg =
                          response.data['error'] ??
                          'Failed to send reservation email.';
                      _showErrorDialog(context, errorMsg);
                    }
                  } catch (e) {
                    print('Error sending email: $e');

                    _showErrorDialog(
                      context,
                      'Something went wrong, please try again.',
                    );
                  }
                } else {
                  _showErrorDialog(
                    context,
                    'Please fill in all required fields.',
                  );
                }
              },

              child: Text(
                'Confirm'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return FormField<String>(
      validator: (value) {
        // You can also check controller value if needed
        if (_phoneController.text.isEmpty) {
          return 'Please enter your phone number'.tr();
        }
        if (_phoneController.text.length < 6) {
          return 'Invalid phone number'.tr();
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntlPhoneField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.secondAppColor.withOpacity(0.2),
                labelText: 'Phone Number *'.tr(),
                labelStyle: const TextStyle(
                  color: AppColors.secondAppColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 32),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.secondAppColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.secondAppColor,
                    width: 2.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2.5,
                  ),
                ),
                hintText: '612539895',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
              dropdownTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              dropdownIcon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.secondAppColor,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              initialCountryCode: 'NL',
              onChanged: (phone) {
                _phoneController.text = phone.number;
                state.didChange(phone.number);
              },
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondAppColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondAppColor, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.secondAppColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          border: InputBorder.none,
        ),
        cursorColor: AppColors.secondAppColor,
      ),
    );
  }
}

void _showSuccessDialog(
  BuildContext context,
  Map<String, dynamic> reservationData,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Wrap(
          children: [
            //  Icon(Icons.check_circle, color: Colors.green, size: 25),
            // const SizedBox(width: 5),
            Text(
              'Reservation Confirmed',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your reservation has been sent successfully 🎉',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              'Date: ${reservationData["date"]}\n'
              'Time: ${reservationData["time"]}\n'
              'Guests: ${reservationData["guests"]}',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // just close dialog
            },
            child: Text('Close', style: TextStyle(color: Colors.green)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              Navigator.of(ctx).pop(); // close dialog first

              // OPTIONAL: show a small loader or snackbar here if you want

              await _sendCancellationEmail(context, reservationData);
            },
            child: const Text(
              'Cancel reservation',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Text(
              'Reservation Failed',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(message, style: const TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

Future<void> _sendCancellationEmail(
  BuildContext context,
  Map<String, dynamic> reservationData,
) async {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 20),
      followRedirects: true,
      maxRedirects: 5,
      validateStatus: (s) => s != null && s < 500,
    ),
  );

  const apiUrl =
      'https://flutter-mail-backend-production.up.railway.app/api/email/cancel';

  // Clone and mark as cancellation (adjust to what your backend expects)
  final cancelData = {
    ...reservationData,
    "type": "cancel", // let the server know this is a cancellation
  };

  try {
    final response = await dio.post(
      apiUrl,
      data: cancelData,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    print('Cancel Status code: ${response.statusCode}');
    print('Cancel Response data: ${response.data}');

    if (response.data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cancellation email sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send cancellation email.')),
      );
    }
  } catch (e) {
    print('Error sending cancellation email: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Something went wrong, please try again.')),
    );
  }
}
