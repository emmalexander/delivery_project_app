import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/models/meal_model.dart';
import 'package:delivery_project_app/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuDialog extends StatelessWidget {
  const MenuDialog({
    Key? key,
    required this.model,
    required this.restaurantId,
  }) : super(key: key);
  final Menu model;
  final String restaurantId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return AlertDialog(
          //contentPadding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: SizedBox(
            height: 230.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      image: model.photo!,
                      placeholder: 'assets/Loading_icon.gif',
                      height: 180.h,
                    )),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.name!),
                    Wrap(
                      spacing: 5,
                      children: [
                        Text(
                          '\u20A6${model.price}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Text('per portion')
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
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
                          context.read<OrderBloc>().add(OrderDecrementEvent());
                        },
                        icon: const Icon(Icons.remove)),
                    Text(state.quantity.toString()),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context.read<OrderBloc>().add(OrderIncrementEvent());
                          //print(state.quantity);
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                final cartItems =
                    BlocProvider.of<CartBloc>(context).state.cartItems;
                // Check if item is in cart already

                if (cartItems.any((item) => item.menu.id == model.id)) {
                  Fluttertoast.showToast(
                      msg: 'Already in cart',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green.withOpacity(.3),
                      textColor: Theme.of(context).textTheme.bodySmall!.color,
                      fontSize: 16.0);
                } else {
                  //add to cart
                  if (cartItems
                      .any((item) => item.restaurantId != restaurantId)) {
                    Fluttertoast.showToast(
                        msg: 'You can only order from one Restaurant at a time',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red.withOpacity(.7),
                        textColor: Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: 16.0);
                  } else {
                    context.read<CartBloc>().add(
                          AddMealToCartEvent(
                            menuModel: MenuModel(
                                menu: model,
                                quantity: state.quantity,
                                restaurantId: restaurantId),
                          ),
                        );
                    Fluttertoast.showToast(
                        msg: '${model.name} Added to cart',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green.withOpacity(.3),
                        textColor: Theme.of(context).textTheme.bodySmall!.color,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  }
                }

                /*  int totalQuantity = 0;
                for (var cartItem in cartItems) {
                  totalQuantity = totalQuantity + cartItem.quantity!;
                }*/
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: Text(
                    'Add (${state.quantity}) to Cart',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
          actionsPadding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
        );
      },
    );
  }
}
