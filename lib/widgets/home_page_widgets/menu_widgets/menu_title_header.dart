import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTitleHeader extends StatelessWidget {
  const MenuTitleHeader({Key? key}) : super(key: key);

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
            'Restaurant Name',
            style: TextStyle(fontSize: 26.sp),
          )),
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
        ],
      ),
    );
  }
}
