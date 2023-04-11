import 'package:delivery_project_app/widgets/back_button_widget.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const id = 'forget_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _emailController;
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const BackButtonWidget(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/94138-lock.json', width: 250),
              Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                'Enter the email address associated with your account',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Form(
                key: _emailFormKey,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  decoration:
                      const InputDecoration(labelText: 'Enter email address'),
                ),
              ),
              SizedBox(height: 20.h),
              ButtonLoadingWidget(
                text: 'Reset Password',
                onPressed: () {
                  final isValid = _emailFormKey.currentState!.validate();
                  FocusScope.of(context).unfocus();
                  if (isValid) {
                    _emailFormKey.currentState!.save();
                    //code goes here
                  }
                },
                loading: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
