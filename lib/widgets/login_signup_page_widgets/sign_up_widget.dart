import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
    required this.onPressed,
    required this.loading,
    required this.iconOnPressed,
    required this.obscureText,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final void Function() onPressed;
  final bool loading;
  final Function() iconOnPressed;
  final bool obscureText;
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
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name field is required';
                    }
                    if (value.length < 2 || value.length > 15) {
                      return 'Name must be between 2 and 15 characters long';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'phone field required';
                    }
                    if (value.length > 14 || value.length < 11) {
                      return 'Invalid phone number format';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email field required';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: passwordController,
                  obscureText: !obscureText,
                  obscuringCharacter: '*',
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regex = RegExp(pattern);
                    if (value!.isEmpty) {
                      return 'Password field required';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Password must be at least 8 characters long and include a mix of uppercase and lowercase letters, numbers, and symbols.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: iconOnPressed,
                          icon: Icon(!obscureText
                              ? Icons.visibility_sharp
                              : Icons.visibility_off)),
                      errorMaxLines: 3,
                      labelText: 'Password'),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        ButtonLoadingWidget(
            text: 'Sign up', onPressed: onPressed, loading: loading),
        SizedBox(height: 70.h)
      ],
    );
  }
}
