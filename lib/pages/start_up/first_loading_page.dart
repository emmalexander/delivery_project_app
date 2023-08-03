import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/start_up/starting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstLoadingPage extends StatefulWidget {
  const FirstLoadingPage({Key? key}) : super(key: key);
  static const id = 'first_loading_page';

  @override
  State<FirstLoadingPage> createState() => _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {
  @override
  void initState() {
    final state = BlocProvider.of<UserBloc>(context).state;
    Future.delayed(const Duration(seconds: 2), () {
      if (state.userToken.isEmpty) {
        Navigator.pushReplacementNamed(context, StartingPage.id);
      } else {
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    });

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
            top: 50,
            left: 50,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.vertical,
              children: [
                Center(
                  child: Image.asset('assets/qc-black.png', height: 150.w),
                ),
                Text(
                  'Food for',
                  style: TextStyle(
                      fontSize: 60.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1),
                ),
                Text(
                  'Everyone',
                  style: TextStyle(
                      fontSize: 60.sp,
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
