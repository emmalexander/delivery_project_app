import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/widgets/cart_page_widgets/cart_widget.dart';
import 'package:delivery_project_app/widgets/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({Key? key}) : super(key: key);
  static const id = 'cart_list_page';

  @override
  Widget build(BuildContext context) {
    bool closeSwipe = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Your Cart is empty'),
            );
          } else {
            return Column(
              children: [
                const Wrap(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.swipe_left_outlined,
                      size: 18,
                    ),
                    Text('swipe left on an item to delete/favorite'),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        return SlideMenu(
                          closeSwipe: closeSwipe,
                          menuItems: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.color,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.favorite_border_outlined),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.color,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                      RemoveMealFromCartEvent(
                                          meal: state.cartItems[index]));
                                  closeSwipe = true;
                                },
                              ),
                            ),
                          ],
                          child: CartWidget(
                            mealName: state.cartItems[index].name!,
                            price: state.cartItems[index].price!.toString(),
                            quantity:
                                state.cartItems[index].quantity!.toString(),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
