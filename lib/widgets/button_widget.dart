import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.loading})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h)),
      child: loading
          ? SizedBox(
              height: 17.h,
              width: 17.w,
              child: const CircularProgressIndicator(color: Colors.black))
          : Text(
              text,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
            ),
    );
  }
}
