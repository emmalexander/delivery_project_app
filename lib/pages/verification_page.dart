import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);
  static const id = 'verification_page';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
              context: context,
              builder: (context) => CustomErrorDialog(
                  title: state.errorTitle,
                  description: state.error,
                  onPressed: () => Navigator.pop(context)));
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                CloseButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
                  },
                ),
              ],
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
                    'Verify email address',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Click ',
                        style:
                            TextStyle(fontSize: 17.sp, color: Colors.black54),
                      ),
                      InkWell(
                          onTap: () {
                            context
                                .read<UserBloc>()
                                .add(VerificationToHomePageEvent());
                          },
                          child: Text(
                            'here',
                            style: TextStyle(
                                fontSize: 17.sp, color: AppColors.mainColor),
                          )),
                      Text(
                        ' after email verification',
                        style:
                            TextStyle(fontSize: 17.sp, color: Colors.black54),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
