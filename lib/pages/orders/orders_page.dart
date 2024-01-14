import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/models/orders_model.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/custom_app_bar.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/orders_widgets/empty_orders_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const id = 'orders_screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    // final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    // context
    //     .read<ApiServices>()
    //     .getOrders(token: blocProviderState.userToken)
    //     .then((value) {
    //   if (value is OrdersModel) {
    //     setState(() {
    //       orders.addAll(value.orders!);
    //     });
    //   } else {}
    //});
  }

  Future<List<Order>> getOrders(BuildContext context) async {
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    final value = await context
        .read<ApiServices>()
        .getOrders(token: blocProviderState.userToken);
    return value.orders;
    //return null;
  }

  void _makePayment(
      {required BuildContext context,
      required List<Order> ordersList,
      required int index}) {
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;

    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Row(
                children: [
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  const SizedBox(width: 10),
                  Container(
                      margin: const EdgeInsets.only(left: 7),
                      child: const Text("paying...")),
                ],
              ),
            ),
          );
        });
    context
        .read<ApiServices>()
        .makePayment(
          orderId: ordersList[index].id,
          token: blocProviderState.userToken,
        )
        .then((value) {
      context
          .read<ApiServices>()
          .getOrders(token: blocProviderState.userToken)
          .then((value) {
        if (value is OrdersModel) {
          setState(() {
            ordersList.addAll(value.orders!);
          });
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Orders'),
      drawer: const MyDrawer(),
      body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: FutureBuilder(
              future: getOrders(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const EmptyOrders();
                } else if (snapshot.hasError) {
                  //print(snapshot.error.toString());
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (snapshot.data![index].status == 'PAID') {
                              Fluttertoast.showToast(
                                  msg: 'Your order is on the way',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green.withOpacity(.3),
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
                                  fontSize: 16.0);
                            } else {
                              _makePayment(
                                  context: context,
                                  ordersList: snapshot.data!,
                                  index: index);
                            }
                          },
                          child: Card(
                            child: ListTile(
                              //   contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                snapshot.data![index].status == 'PENDING'
                                    ? Icons.pending
                                    : Icons.check_circle,
                                color: snapshot.data![index].status == 'PENDING'
                                    ? Colors.amber
                                    : Colors.green,
                              ),
                              title: Text('Order ${index + 1}'),
                              subtitle: Text(
                                  'Status ${snapshot.data![index].status}'),
                            ),
                          ),
                        );
                      });
                }
              })
          /*orders.isEmpty
            ? const EmptyOrders()
            : Flexible(
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final blocProviderState =
                              BlocProvider.of<UserBloc>(context).state;

                          showDialog(
                              context: context,
                              builder: (context) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child: AlertDialog(
                                    content: Row(
                                      children: [
                                        const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2)),
                                        const SizedBox(width: 10),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 7),
                                            child: const Text("paying...")),
                                      ],
                                    ),
                                  ),
                                );
                              });
                          context
                              .read<ApiServices>()
                              .makePayment(
                                orderId: orders[index].id,
                                token: blocProviderState.userToken,
                              )
                              .then((value) {
                            context
                                .read<ApiServices>()
                                .getOrders(token: blocProviderState.userToken)
                                .then((value) {
                              if (value is OrdersModel) {
                                setState(() {
                                  orders.addAll(value.orders!);
                                });
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                              }
                            });
                          });
                        },
                        child: Card(
                          child: ListTile(
                            //   contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              orders[index].status == 'PENDING'
                                  ? Icons.pending
                                  : Icons.check_circle,
                              color: orders[index].status == 'PENDING'
                                  ? Colors.amber
                                  : Colors.green,
                            ),
                            title: Text('Order ${index + 1}'),
                            subtitle: Text('Status ${orders[index].status}'),
                          ),
                        ),
                      );
                    }),
              ),*/
          ),
    );
  }
}
