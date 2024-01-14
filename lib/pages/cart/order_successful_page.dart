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
        const Duration(seconds: 50),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.id,
              (Route<dynamic> route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.electric_bike, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'You will be redirected to order screen\n to complete payment',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
