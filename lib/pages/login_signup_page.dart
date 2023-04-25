import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/otp_page.dart';
import 'package:delivery_project_app/pages/verification_page.dart';
import 'package:delivery_project_app/widgets/log_in_widget.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:delivery_project_app/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInSignUpPage extends StatefulWidget {
  const LogInSignUpPage({Key? key}) : super(key: key);
  static const id = 'login_signup_page';

  @override
  State<LogInSignUpPage> createState() => _LogInSignUpPageState();
}

class _LogInSignUpPageState extends State<LogInSignUpPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _loginEmailController;
  late TextEditingController _loginPasswordController;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _signupEmailController;
  late TextEditingController _signupPasswordController;

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _signupEmailController = TextEditingController();
    _signupPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();

    _nameController.dispose();
    _phoneController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();

    super.dispose();
  }

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
          if (state is OtpState) {
            return const OtpPage();
          } else if (state is VerificationState) {
            return const VerificationPage();
          } else if (state is UserAddedState) {
            // this state should take you to the home page with the userModel as a state variable
            return const HomePage();
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              // resizeToAvoidBottomInset: true,
              body: SizedBox(
                height: double.maxFinite,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 290.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(30.r),
                        //     bottomRight: Radius.circular(30.r)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Container(),
                          Center(
                            child: Image.asset('assets/qc-black.png',
                                width: 220.w),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:
                                TabBar(controller: _tabController, tabs: const [
                              Text(
                                'Login',
                              ),
                              Text(
                                'Sign-up',
                              ),
                            ]),
                          ),
                          //SizedBox(height: 1)
                        ],
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: 400.w,
                              height: 650.h,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  LogInWidget(
                                    formKey: _loginFormKey,
                                    emailController: _loginEmailController,
                                    passwordController:
                                        _loginPasswordController,
                                    loading: state.loginLoading ?? false,
                                    onPressed: () {
                                      final isValid = _loginFormKey
                                          .currentState!
                                          .validate();
                                      FocusScope.of(context).unfocus();
                                      if (isValid) {
                                        _loginFormKey.currentState!.save();
                                        //code goes here
                                        context
                                            .read<UserBloc>()
                                            .add(LogToOtpEvent(
                                              email: _loginEmailController.text,
                                              password:
                                                  _loginPasswordController.text,
                                            ));
                                      }
                                    },
                                  ),
                                  SignUpWidget(
                                    formKey: _signupFormKey,
                                    emailController: _signupEmailController,
                                    passwordController:
                                        _signupPasswordController,
                                    phoneController: _phoneController,
                                    nameController: _nameController,
                                    onPressed: () {
                                      final isValid = _signupFormKey
                                          .currentState!
                                          .validate();
                                      FocusScope.of(context).unfocus();
                                      if (isValid) {
                                        _signupFormKey.currentState!.save();
                                        context
                                            .read<UserBloc>()
                                            .add(SignUpToVerificationEvent(
                                              name: _nameController.text,
                                              email:
                                                  _signupEmailController.text,
                                              phone: _phoneController.text,
                                              password:
                                                  _signupPasswordController
                                                      .text,
                                            ));
                                      }
                                    },
                                    loading: state.signupLoading ?? false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
