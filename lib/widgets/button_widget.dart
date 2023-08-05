import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.fontWeight = FontWeight.w600,
      this.horizontalPadding = 100,
      this.verticalPadding = 10,
      this.buttonTextSize = 17,
      required this.loading})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  final bool loading;
  final FontWeight fontWeight;
  final double horizontalPadding;
  final double verticalPadding;
  final double buttonTextSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding)),
      child: loading
          ? SizedBox(
              height: 17.h,
              width: 17.w,
              child: const CircularProgressIndicator(color: Colors.black))
          : Text(
              text,
              style:
                  TextStyle(fontSize: buttonTextSize, fontWeight: fontWeight),
            ),
    );
  }
}
