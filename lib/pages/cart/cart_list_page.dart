import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/order_successful_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:delivery_project_app/widgets/cart_page_widgets/cart_widget.dart';
import 'package:delivery_project_app/widgets/cart_page_widgets/empty_cart_widget.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);
  static const id = 'cart_list_page';

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  bool loading = false;

  void _orderMeal(
      {required CartState state,
      required UserState userState,
      required BuildContext context}) {
    Navigator.pop(context);
    setState(() {
      loading = true;
    });
    List<Map<String, dynamic>> menuList = [];
    for (var menu in state.cartItems) {
      menuList.add({'quantity': menu.quantity, 'id': menu.menu.id});
    }
    context
        .read<ApiServices>()
        .orderFood(
            restaurantId: state.cartItems.first.restaurantId,
            menuList: menuList,
            token: userState.userToken)
        .then((value) {
      setState(() {
        loading = false;
      });
      context.read<CartBloc>().add(ClearCartEvent());
      //Take User to Success Screen
      Navigator.pushNamed(context, OrderSuccessfulPage.id);
    });
  }

  Future<void> _order(
      {required CartState state,
      required UserState userState,
      required BuildContext context}) async {
    int sum = 0;
    for (var v in state.cartItems) {
      sum = sum + (v.menu.price! * v.quantity!);
    }
    //debugPrint(sum.toString());
    // Order
    if (sum > userState.balance!) {
      Fluttertoast.showToast(
          msg: 'You do not have \u20A6$sum in your wallet',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          //timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Theme.of(context).textTheme.bodySmall!.color,
          fontSize: 16.0);
    } else {
      setState(() {
        loading = false;
      });

      showDialog(
          context: context,
          builder: (context) => CustomErrorDialog(
              title: 'Proceed?',
              description: 'Total Cost is \u20A6$sum',
              onPressed: () {
                _orderMeal(
                    state: state, userState: userState, context: context);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.cartItems.isEmpty) {
                return const EmptyCartWidget();
              } else {
                return Stack(
                  children: [
                    Column(
                      children: [
                        const Wrap(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.swipe_left_outlined,
                              size: 18,
                            ),
                            Text('Swipe left on an item to delete/favorite'),
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
                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),
                                    children: [
                                      SlidableAction(
                                        padding: EdgeInsets.zero,
                                        // flex: 2,
                                        onPressed: (_) {
                                          context.read<CartBloc>().add(
                                              RemoveMealFromCartEvent(
                                                  menuModel:
                                                      state.cartItems[index]));
                                        },
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
                                    ],
                                  ),
                                  child: CartWidget(
                                    mealName: state.cartItems[index].menu.name!,
                                    imgUrl: state.cartItems[index].menu.photo!,
                                    price: state.cartItems[index].menu.price
                                        .toString(),
                                    quantity: state.cartItems[index].quantity!,
                                    increaseQuantity: () {
                                      setState(() {
                                        context.read<CartBloc>().add(
                                            QuantityIncreaseEvent(
                                                index: index));
                                      });
                                    },
                                    decreaseQuantity: () {
                                      setState(() {
                                        context.read<CartBloc>().add(
                                            QuantityDecreaseEvent(
                                                index: index));
                                      });
                                    },
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ButtonLoadingWidget(
                              text: 'Order',
                              onPressed: () {
                                _order(
                                    state: state,
                                    userState: userState,
                                    context: context);
                              },
                              loading: loading),
                        ))
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
