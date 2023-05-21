import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    Key? key,
    this.otpController,
    required this.onChanged,
    required this.onCompleted,
  }) : super(key: key);
  final TextEditingController? otpController;
  final Function(String) onChanged;
  final Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      //controller: otpController,
      backgroundColor: Colors.transparent,
      animationType: AnimationType.none,
      appContext: context,
      keyboardType: TextInputType.number,
      length: 4,
      textInputAction: TextInputAction.done,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'OTP field required';
      //   } else if (value.length < 4) {
      //     return 'Incomplete field';
      //   } else {
      //     return null;
      //   }
      // },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60,
        fieldWidth: 60,
        activeFillColor: Colors.white,
        activeColor: Theme.of(context).textTheme.titleMedium!.color,
        inactiveColor: Theme.of(context).textTheme.titleMedium!.color,
        selectedColor: AppColors.mainColor,
      ),
      // cursorColor: Colors.black,
      //animationDuration: Duration(milliseconds: 300),
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}
