import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchLocationWidget extends StatelessWidget {
  const SearchLocationWidget(
      {Key? key,
      required this.locationController,
      required this.suffixIcon,
      required this.onChanged,
      required this.onTap})
      : super(key: key);
  final TextEditingController locationController;
  final IconButton? suffixIcon;
  final Function(String) onChanged;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40.h,
      padding: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.searchBarColor,
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.search,
            color: Colors.grey,
          ),
          Center(
            child: SizedBox(
              width: 325.w,
              child: TextField(
                onTap: onTap,
                controller: locationController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.w, bottom: 10),
                    hintText: 'Search location',
                    suffixIcon: suffixIcon,
                    border: InputBorder.none),
                onChanged: onChanged,
              ),
            ),
          )
        ],
      ),
    );
  }
}
