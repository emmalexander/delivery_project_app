import 'package:delivery_project_app/consts/app_colors.dart';
import 'package:flutter/material.dart';

class DeleteContainer extends StatelessWidget {
  const DeleteContainer({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: ShapeDecoration(
          color: AppColors.mainColor,
          shape: const OvalBorder(),
        ),
        child: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}
