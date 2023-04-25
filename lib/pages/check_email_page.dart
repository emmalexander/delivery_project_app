import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({Key? key}) : super(key: key);
  static const id = 'check_email_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/98814-email.json',
              height: 200.h,
            ),
            Text(
              'Check email address',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              'A new password has been sent to your email',
              style: TextStyle(fontSize: 17.sp, color: Colors.black54),
            ),
            ButtonLoadingWidget(
              text: 'Login',
              onPressed: () {
                Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
              },
              loading: false,
            )
          ],
        ),
      ),
    );
  }
}
