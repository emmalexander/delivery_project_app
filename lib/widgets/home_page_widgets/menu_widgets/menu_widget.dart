import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_dialog.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.model,
    required this.restaurantId,
  }) : super(key: key);
  final Menu model;
  final String restaurantId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
                context: context,
                builder: (context) =>
                    MenuDialog(model: model, restaurantId: restaurantId))
            .then((value) => context.read<OrderBloc>().add(ClearCountEvent()));
      },
      child: Container(
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
                Text(
                  model.name!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3,
                  children: [
                    const Text('Status: '),
                    const Text('Available'),
                    Icon(
                      Icons.circle,
                      color: model.available! ? Colors.green : Colors.red,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  '\u20A6${model.price!}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: AppColors.mainColor),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FadeInImage.assetNetwork(
                  height: 80,
                  placeholder: 'assets/Loading_icon.gif',
                  image: model.photo!,
                ))
          ],
        ),
      ),
    );
  }
}
