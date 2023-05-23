// ignore_for_file: must_be_immutable

import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/otp_page_widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendCodeWidget extends StatefulWidget {
  ResendCodeWidget({Key? key, required this.resendClicked, required this.email})
      : super(key: key);
  bool resendClicked;
  String email;

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.resendClicked
          ? null
          : () async {
              setState(() {
                widget.resendClicked = true;
              });
              await context.read<ApiServices>().retryOtp(widget.email);
              /* .then((value) {
                                  //code goes here
                                });*/
            },
      child: widget.resendClicked
          ? SizedBox(
              height: 20,
              width: 50,
              child: TimerWidget(changeResendClicked: () {
                setState(() {
                  widget.resendClicked = false;
                });
              }),
            )
          : Text(
              'Resend Code',
              style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: AppColors.mainColor),
            ),
    );
  }
}
