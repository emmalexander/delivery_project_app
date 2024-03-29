import 'package:delivery_project_app/blocs/switch_bloc/switch_bloc.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/auth_pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/orders/orders_page.dart';
import 'package:delivery_project_app/pages/profile_pages/profile_page.dart';
import 'package:delivery_project_app/pages/promo/promo_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appcheck/appcheck.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Future<void> openSettingsApp() async {
    if (await AppCheck.isAppEnabled("com.android.settings")) {
      // Settings app is installed, launch it
      AppCheck.launchApp("com.android.settings");
    } else {
      // Settings app is not installed, show an error message
      //print("Settings app not installed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370.w,
      child: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.h),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 40.h),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                onTap: () {
                  // do something
                  Navigator.pushReplacementNamed(context, HomePage.id);
                },
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: const Text('Profile'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: () {
                  // do something
                  Navigator.pushReplacementNamed(context, ProfilePage.id);
                },
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart_rounded),
                title: const Text('My orders'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersScreen()));
                },
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.discount_outlined),
                title: const Text('Promo'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PromoPage()));
                },
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.question_mark_rounded),
                title: const Text('F.A.Q'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: () {
                  // do something
                },
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.notifications_none_rounded),
                title: const Text('Notifications'),
                onTap: () {
                  // do something
                  openSettingsApp();
                },
                trailing: const Icon(
                  Icons.open_in_new,
                  size: 20,
                ),
              ),
              const SizedBox(width: 170, child: Divider()),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => CustomErrorDialog(
                          isLogout: true,
                          title: 'Log out',
                          description: 'Are you sure?',
                          onPressed: () async {
                            // showDialog(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (context) => WillPopScope(
                            //           onWillPop: () async => false,
                            //           child: AlertDialog(
                            //             content: Row(
                            //               children: [
                            //                 const CircularProgressIndicator(),
                            //                 const SizedBox(width: 10),
                            //                 Container(
                            //                     margin: const EdgeInsets.only(
                            //                         left: 7),
                            //                     child: const Text(
                            //                         "Logging out...")),
                            //               ],
                            //             ),
                            //           ),
                            //         ));
                            await context
                                .read<ApiServices>()
                                .logout(BlocProvider.of<UserBloc>(context)
                                    .state
                                    .userToken)
                                .then((value) {
                              context.read<UserBloc>().add(RemoveUserToken());
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LogInSignUpPage.id,
                                (Route<dynamic> route) => false,
                              );
                            });
                          }));
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () {
                          context.read<SwitchBloc>().add(const SwitchEvent());
                        },
                        child: Icon(
                          state.switchValue
                              ? Icons.dark_mode
                              : Icons.light_mode_rounded,
                          size: 30,
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
