import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.balance}) : super(key: key);
  final String? balance;
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        Text(
          'NGN $balance',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color:
                Theme.of(context).textTheme.titleMedium!.color!.withOpacity(.3),
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
