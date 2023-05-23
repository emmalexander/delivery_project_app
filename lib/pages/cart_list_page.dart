import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/widgets/cart_page_widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            // TODO Implement swipe to delete and add to favorite
            return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  return CartWidget(
                    mealName: state.cartItems[index].name!,
                    price: state.cartItems[index].price!.toString(),
                    quantity: state.cartItems[index].quantity!.toString(),
                  );
                });
          }
        },
      ),
    );
  }
}
