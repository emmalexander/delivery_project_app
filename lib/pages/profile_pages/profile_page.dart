import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/global_constants.dart';
import 'package:delivery_project_app/pages/profile_pages/change_profile_page.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/profile_page_widgets/profile_list_tile_widget.dart';
import 'package:delivery_project_app/widgets/profile_page_widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const id = 'profile_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/menu.svg',
                colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.titleMedium!.color!,
                    BlendMode.srcIn),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'My Profile',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        state.balance == null
                            ? 'NGN 0.00'
                            : 'NGN ${state.balance!.toStringAsFixed(2).replaceAllMapped(thirdNumberCommaPattern, mathFunc)}',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Personal details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ChangeProfilePage.id);
                          },
                          child: const Text(
                            'change',
                            style: TextStyle(fontSize: 15),
                          ))
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const ProfileWidget(),
                  SizedBox(height: 20.h),
                  const ProfileListTileWidget(title: 'Orders'),
                  SizedBox(height: 20.h),
                  const ProfileListTileWidget(title: 'Cards'),
                  SizedBox(height: 20.h),
                  const ProfileListTileWidget(title: 'Favorites'),
                  SizedBox(height: 20.h),
                  const ProfileListTileWidget(title: 'Help'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
