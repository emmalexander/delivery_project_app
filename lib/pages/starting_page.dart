import 'dart:async';

import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);
  static const id = 'starting_page';

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, LogInSignUpPage.id));
    super.initState();
  }

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
            child: SizedBox(
                height: 17.h,
                width: 17.w,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.black)),
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
