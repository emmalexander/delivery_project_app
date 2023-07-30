import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/widgets/cart_page_widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({Key? key}) : super(key: key);
  static const id = 'cart_list_page';

  @override
  Widget build(BuildContext context) {
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
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.3,
                            dragDismissible: false,
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: [
                              SlidableAction(
                                padding: EdgeInsets.zero,
                                // flex: 2,
                                onPressed: (_) {},
                                backgroundColor: Colors.transparent,
                                foregroundColor: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                                icon: Icons.delete_outline,
                              ),
                              SlidableAction(
                                padding: EdgeInsets.zero,
                                onPressed: (_) {},
                                backgroundColor: Colors.transparent,
                                foregroundColor: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                                icon: Icons.favorite_border_outlined,
                              ),
                              // FavoriteContainer(onTap: () {}),
                              // DeleteContainer(onTap: () {})
                            ],
                          ),
                          child: CartWidget(
                            mealName: state.cartItems[index].menu.name!,
                            imgUrl: state.cartItems[index].menu.photo!,
                            price: state.cartItems[index].menu.price.toString(),
                            quantity: state.cartItems[index].quantity!,
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
