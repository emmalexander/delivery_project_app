import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/auth_pages/check_email_page.dart';
import 'package:delivery_project_app/widgets/back_button_widget.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        //resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: const BackButtonWidget(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/94138-lock.json', width: 250),
                Text(
                  'Forgot Password?',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Enter the email address associated with your account',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
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
                  onPressed: () async {
                    final isValid = _emailFormKey.currentState!.validate();
                    FocusScope.of(context).unfocus();
                    if (isValid) {
                      _emailFormKey.currentState!.save();
                      //code goes here
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => WillPopScope(
                                onWillPop: () async => false,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                      await context
                          .read<UserBloc>()
                          .apiServices
                          .resetPassword(_emailController.text)
                          .then((value) {
                        if (value.toString().contains('check email')) {
                          Navigator.pushReplacementNamed(
                              context, CheckEmailPage.id);
                        } else {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => CustomErrorDialog(
                                  title: 'Email',
                                  description: 'Invalid email',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }));
                        }
                      });
                    }
                  },
                  loading: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
