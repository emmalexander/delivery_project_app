import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:delivery_project_app/widgets/custom_app_bar.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Promo'),
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ohh snap! No offers yet',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              'Quickchop doesn’t have any offers\nyet please check again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.black.withOpacity(.5), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
