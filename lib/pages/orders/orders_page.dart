import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/models/orders_model.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/custom_app_bar.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/orders_widgets/empty_orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    context
        .read<ApiServices>()
        .getOrders(token: blocProviderState.userToken)
        .then((value) {
      if (value is OrdersModel) {
        setState(() {
          orders.addAll(value.orders!);
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Orders'),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            orders.isEmpty
                ? const EmptyOrders()
                : Flexible(
                    child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
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
                                subtitle:
                                    Text('Status ${orders[index].status}'),
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
