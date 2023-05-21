import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Theme.of(context).cardColor.withOpacity(.5),
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.search),
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 9.h, left: 10.w),
                hintText: 'Search restaurants',
                enabledBorder:
                    const UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
