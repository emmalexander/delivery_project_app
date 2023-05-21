import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.w),
        padding: EdgeInsets.only(
          left: 10.w,
          top: 10.h,
          bottom: 10.h,
        ),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
