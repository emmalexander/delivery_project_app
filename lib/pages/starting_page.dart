import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);
  static const id = 'starting_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            bottom: 250,
            child: Image.asset('assets/images/pizza.png'),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            child: Image.asset('assets/images/burger.png'),
          ),
          Positioned(
            bottom: 60,
            right: 0,
            child: Image.asset('assets/images/boy.png'),
          ),
          Positioned(
            bottom: -50,
            child: Image.asset('assets/images/blur.png'),
          ),
          Positioned(
            bottom: 20,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.mainColor),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 100.w),
                child: const Text('Get Started'),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 60,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.vertical,
              children: [
                const Center(
                  child: Icon(
                    Icons.delivery_dining_outlined,
                    size: 100,
                  ),
                ),
                Text(
                  'Food for',
                  style: TextStyle(
                      fontSize: 65.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1),
                ),
                Text(
                  'Everyone',
                  style: TextStyle(
                      fontSize: 65.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
