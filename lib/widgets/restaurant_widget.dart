import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Image.asset('assets/images/restaurant.png'),
            SizedBox(height: 10.h),
            Text(
              'Restaurant Name',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
            ),
            Text(
              '100km',
              style: TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
