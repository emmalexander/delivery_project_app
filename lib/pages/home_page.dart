import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/widgets/home_app_bar.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/restaurant_widget.dart';
import 'package:delivery_project_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: const HomeAppBar(),
            drawer: const MyDrawer(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomSearchBar(),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) =>
                              const RestaurantWidget()))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
