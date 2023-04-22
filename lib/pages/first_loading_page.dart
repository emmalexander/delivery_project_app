import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/starting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstLoadingPage extends StatefulWidget {
  const FirstLoadingPage({Key? key}) : super(key: key);
  static const id = 'first_loading_page';

  @override
  State<FirstLoadingPage> createState() => _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {
  @override
  void initState() {
    final state = BlocProvider.of<UserBloc>(context).state;
    Future.delayed(const Duration(seconds: 2), () {
      if (state.userToken.isEmpty) {
        Navigator.pushReplacementNamed(context, StartingPage.id);
      } else {
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
