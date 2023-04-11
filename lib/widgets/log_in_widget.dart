import 'package:delivery_project_app/pages/forgot_password.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget(
      {Key? key,
      required this.formKey,
      required this.emailController,
      required this.passwordController,
      required this.onPressed,
      required this.loading})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() onPressed;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  obscuringCharacter: '*',
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password field required';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(height: 180.h),
        ButtonLoadingWidget(
            text: 'Login', onPressed: onPressed, loading: loading),
        // TextButton(
        //   onPressed: loading ? null : onPressed,
        //   style: TextButton.styleFrom(
        //       padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 15.h)),
        //   child: loading
        //       ? SizedBox(
        //           height: 17.h,
        //           width: 17.w,
        //           child: const CircularProgressIndicator(color: Colors.black))
        //       : Text(
        //           'Login',
        //           style:
        //               TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
        //         ),
        // ),
        SizedBox(height: 25.h)
      ],
    );
  }
}
