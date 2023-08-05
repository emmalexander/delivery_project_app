import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Image.asset(
            'assets/images/order.png',
            width: 100,
          ),
          const SizedBox(height: 5),
          const Text(
            'No orders yet',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            'Hit the orange button down\nbelow to Create an order',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: AppColors.black.withOpacity(.5), fontSize: 15),
          ),
          const Spacer(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ButtonLoadingWidget(
                    text: 'Start ordering',
                    horizontalPadding: 70,
                    verticalPadding: 13,
                    onPressed: () async {},
                    buttonTextSize: 15,
                    loading: false),
              ))
        ],
      ),
    );
  }
}
