import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTitleHeader extends StatelessWidget {
  const MenuTitleHeader(
      {Key? key,
      required this.restaurantName,
      required this.available,
      required this.rating})
      : super(key: key);
  final String restaurantName;
  final bool available;
  final String? rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Column(
        children: [
          Center(
              child: Text(
            restaurantName,
            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
          )),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 3,
            children: [
              const Text('Status: '),
              const Text('Available'),
              Icon(
                Icons.circle,
                color: available ? Colors.greenAccent : Colors.redAccent,
                size: 15,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  rating == null ? const Text('No rating') : Text('$rating%'),
                  SizedBox(width: 5.w),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.hand_thumbsup,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const Text('Delivery Time: 25-35 mins')
            ],
          ),
        ],
      ),
    );
  }
}
