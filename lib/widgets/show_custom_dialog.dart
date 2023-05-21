import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.onPressed,
      this.isLogout = false})
      : super(key: key);
  final String title;
  final String description;
  final Function() onPressed;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(title),
      content: Text(description),
      actions: [
        isLogout
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: AppColors.mainColor, fontWeight: FontWeight.w600),
                ),
              )
            : Container(),
        SizedBox(width: 10.w),
        isLogout
            ? TextButton(
                onPressed: onPressed,
                child: const Text(
                  'Yes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : TextButton(
                onPressed: onPressed,
                child: const Text(
                  'Ok',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
      ],
    );
  }
}
