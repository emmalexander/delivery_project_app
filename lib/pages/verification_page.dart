import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);
  static const id = 'verification_page';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Verify email address',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                Wrap(
                  children: [
                    const Text('Click '),
                    InkWell(
                        onTap: () async {
                          SharedPreferences storage =
                              await SharedPreferences.getInstance();
                          final token = storage.getString('TOKEN');
                          await ApiServices().getUser(token).then((value) {
                            // context
                            //     .read<UserBloc>()
                            //     .add(AddUserToken(userToken: value!.token!));
                            if (value!.verified == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(user: value)));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomErrorDialog(
                                      title: 'Not Verified',
                                      description: 'Please verify your email',
                                      onPressed: () =>
                                          Navigator.of(context).pop()));
                              // showCustomDialog(
                              //     context,
                              //     'Not Verified',
                              //     'Please verify your email',
                              //     () => Navigator.of(context).pop());
                            }
                          });
                        },
                        child: const Text(
                          'here',
                          style: TextStyle(color: Colors.blue),
                        )),
                    const Text(' after email verification')
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
