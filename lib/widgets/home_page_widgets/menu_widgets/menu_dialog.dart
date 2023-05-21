import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDialog extends StatelessWidget {
  const MenuDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        height: 270.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/meal1.jpg',
                  height: 180.h,
                )),
            SizedBox(height: 10.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Menu 1'),
                Wrap(
                  children: [
                    Text(
                      'N10 ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('per portion')
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 40.h,
              width: 280.w,
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<OrderBloc>()
                                        .add(OrderDecrementEvent());
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(state.counter.toString()),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<OrderBloc>()
                                        .add(OrderIncrementEvent());
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Add (${state.counter}) to Cart',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
