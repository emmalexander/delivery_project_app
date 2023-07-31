import 'package:delivery_project_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatefulWidget {
  const OrderSuccessfulPage({super.key});
  static const id = 'order_successful_page';

  @override
  State<OrderSuccessfulPage> createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.id,
              (Route<dynamic> route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 35, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Order Successful',
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
