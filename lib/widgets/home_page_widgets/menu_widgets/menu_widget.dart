import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_dialog.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => const MenuDialog())
            .then((value) => context.read<OrderBloc>().add(ClearCountEvent()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu 1',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3,
                  children: [
                    Text('Status: '),
                    Text('Available'),
                    Icon(
                      Icons.circle,
                      color: Colors.greenAccent,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  'N10',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.mainColor),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                'assets/meal1.jpg',
                height: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
