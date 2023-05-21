import 'package:delivery_project_app/widgets/home_page_widgets/menu_widgets/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  static const id = 'menu_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/resaurant1.jpg')),
                const Text(
                  'Restaurant Name',
                  style: TextStyle(
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1))
                    ],
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 3,
              children: [
                Text('Status: '),
                Text('Available'),
                Icon(
                  Icons.circle,
                  color: Colors.greenAccent,
                  size: 15,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('80%'),
                    SizedBox(width: 5.w),
                    const Icon(
                      CupertinoIcons.hand_thumbsup,
                      size: 18,
                    ),
                  ],
                ),
                const Text('Delivery Time: 25-35 mins')
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const MenuWidget();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
