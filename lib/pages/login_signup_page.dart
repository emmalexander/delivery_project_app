import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/widgets/log_in_widget.dart';
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

  void _submitFormOnRegister() async {
    final isValid = _signupFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    final blocProvider = BlocProvider.of<UserBloc>(context);
    if (isValid) {
      _signupFormKey.currentState!.save();
      blocProvider.add(CreateUser(
        name: _nameController.text,
        email: _signupEmailController.text,
        phone: _phoneController.text,
        password: _signupPasswordController.text,
      ));
    }
  }

  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _loginFormKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 980.h,
          child: Column(
            children: [
              Container(
                height: 330.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Center(
                      child: Icon(
                        Icons.delivery_dining_outlined,
                        size: 100,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TabBar(
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          labelColor: Colors.black,
                          labelPadding: EdgeInsets.symmetric(vertical: 10.h),
                          indicatorColor: AppColors.mainColor,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 50.w),
                          controller: _tabController,
                          tabs: const [
                            Text(
                              'Login',
                            ),
                            Text(
                              'Sign-up',
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LogInWidget(
                      formKey: _loginFormKey,
                      emailController: _loginEmailController,
                      passwordController: _loginPasswordController,
                      onPressed: () {
                        _submitFormOnLogin();
                      },
                    ),
                    SignUpWidget(
                      formKey: _signupFormKey,
                      emailController: _signupEmailController,
                      passwordController: _signupPasswordController,
                      phoneController: _phoneController,
                      nameController: _nameController,
                      onPressed: () {
                        _submitFormOnRegister();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
