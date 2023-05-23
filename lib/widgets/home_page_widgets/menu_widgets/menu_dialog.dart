import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDialog extends StatelessWidget {
  const MenuDialog({Key? key}) : super(key: key);

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
                    child: Image.asset(
                      'assets/meal1.jpg',
                      height: 180.h,
                    )),
                SizedBox(height: 20.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Menu 1'),
                    Wrap(
                      spacing: 5,
                      children: [
                        Text(
                          '\u20A610',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text('per portion')
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
                // final cartItems =
                //     BlocProvider.of<CartBloc>(context).state.cartItems;
                // TODO Check if item is in cart already

                /* if(cartItems.any((item) => item.id == meal.id)){
                  //show snackbar
                }else{
                  //add to cart
                }*/

                context.read<CartBloc>().add(
                      AddMealToCartEvent(
                        meal: MealModel(
                          id: 'aswerq12',
                          name: 'burger',
                          available: true,
                          price: 10.0,
                          photoUrl:
                              'https://media-cdn.tripadvisor.com/media/photo-s/1a/99/aa/92/outdoor-seating-area.jpg',
                          quantity: state.quantity,
                        ),
                      ),
                    );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).cardColor,
                  content: Text(
                    'Meal 1 Added to cart',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ));
                Navigator.pop(context);

                // TODO Try and get the total number of quantity to display in the badge
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
