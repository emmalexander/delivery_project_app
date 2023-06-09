import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartWidget extends StatelessWidget {
  const CartWidget(
      {Key? key,
      required this.mealName,
      required this.price,
      required this.quantity})
      : super(key: key);
  final String mealName;
  final String price;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/meal1.jpg',
            width: 90,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mealName),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u20A6 $price',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor),
                  ),
                  const SizedBox(width: 120),
                  Container(
                    height: 30,
                    //width: 100,
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
                                //context.read<OrderBloc>().add(OrderDecrementEvent());
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 15,
                              )),
                          Text(quantity),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                // context.read<OrderBloc>().add(OrderIncrementEvent());
                                //print(state.quantity);
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 15,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
