import 'package:delivery_project_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.error}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            error.contains('Email already exists')
                ? const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                    size: 100,
                  )
                : Image.asset('assets/images/no_internet.png'),
            const SizedBox(height: 20),
            Text(
              error,
              style: TextStyle(
                fontSize: 23.sp,
              ),
            ),
            const SizedBox(height: 20),
            error.contains('Email already exists')
                ? Column(
                    children: [
                      TextButton(
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                          child: Text('Sign In'),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(SignInPage.id);
                        },
                      ),
                      // const SizedBox(height: 20),
                      // TextButton(
                      //   child:const Padding(
                      //     padding:  EdgeInsets.symmetric(
                      //         vertical: 5, horizontal: 68),
                      //     child:  Text('Verify email'),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed(VerificationPage.id);
                      //   },
                      // ),
                    ],
                  )
                : TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 80),
                      child: Text(
                        'Try again',
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    onPressed: () {},
                  )
          ],
        ),
      ),
    );
  }
}
