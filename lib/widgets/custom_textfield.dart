import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toro_app/const/colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
                      value!.isEmpty ? 'Please enter your first name'.tr() : null,
            ),
            const SizedBox(height: 12),
            _buildLabeledField(
              label: 'Last Name *'.tr(),
              controller: _lastNameController,
              validator:
                  (value) =>
                      value!.isEmpty ? 'Please enter your last name'.tr() : null,
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

            // _buildLabeledField(
            //   label: 'Phone Number *',
            //   controller: _phoneController,
            //   keyboardType: TextInputType.phone,
            //   validator:
            //       (value) => value!.isEmpty ? 'Please enter your Number' : null,
            // ),
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
              onPressed: () {
                final isValid = _formKey.currentState?.validate() ?? false;

                if (isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text('Form submitted successfully'.tr()),
                    ),
                  );
                  print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text('Please Enter your data'.tr()),
                    ),
                  );
                }
                // if (_formKey.currentState!.validate()) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Form submitted successfully'),
                //     ),
                //   );
                //   print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
                // }
              },
              child:  Text(
                'Next'.tr(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
