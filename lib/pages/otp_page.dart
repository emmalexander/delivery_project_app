import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:delivery_project_app/widgets/otp_text_field.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);
  static const id = 'otp_page';
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late TextEditingController _otpController;
  //final _otpFormKey = GlobalKey<FormState>();
  late String otp;

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
              context: context,
              builder: (context) => CustomErrorDialog(
                  title: 'Error',
                  description: state.error,
                  onPressed: () => Navigator.pop(context)));
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/88252-data-security.json',
                      height: 200.h,
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                    Text(
                      'Enter your OTP code sent to ${state.email} expires in 10 minutes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      width: 330.w,
                      height: 180.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 25.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtpTextField(
                            otpController: _otpController,
                            onChanged: (val) {},
                            onCompleted: (val) {
                              // final isValid =
                              //     _otpFormKey.currentState!.validate();
                              FocusScope.of(context).unfocus();
                              // if (isValid) {
                              //   _otpFormKey.currentState!.save();
                              //code goes here
                              context.read<UserBloc>().add(OtpToHomePageEvent(
                                  email: state.email!, otp: val));
                              // }
                            },
                          ),
                          ButtonLoadingWidget(
                            text: 'Verify',
                            onPressed: _otpController.text.length > 3
                                ? () {
                                    // final isValid =
                                    //     _otpFormKey.currentState!.validate();
                                    FocusScope.of(context).unfocus();
                                    // if (isValid) {
                                    //   _otpFormKey.currentState!.save();
                                    //code goes here
                                    context.read<UserBloc>().add(
                                        OtpToHomePageEvent(
                                            email: state.email!,
                                            otp: _otpController.text));
                                    //}
                                  }
                                : null,
                            loading: state.otpLoading,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Didn\'t receive any code?',
                      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Resend Code',
                      style: TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: AppColors.mainColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
