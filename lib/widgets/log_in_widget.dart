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
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                  decoration: const InputDecoration(labelText: 'Email Address'),
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
                  decoration: const InputDecoration(labelText: 'Password'),
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
        const Spacer(),
        //SizedBox(height: 180.h),
        ButtonLoadingWidget(
            text: 'Login', onPressed: onPressed, loading: loading),
        SizedBox(height: 70.h)
      ],
    );
  }
}
