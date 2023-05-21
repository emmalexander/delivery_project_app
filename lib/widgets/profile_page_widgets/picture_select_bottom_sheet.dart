import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureSelectBottomSheet extends StatelessWidget {
  const PictureSelectBottomSheet(
      {Key? key, this.onPressedCamera, this.onPressedGallery})
      : super(key: key);
  final Function()? onPressedCamera;
  final Function()? onPressedGallery;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: onPressedCamera,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: onPressedGallery,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  icon: const Icon(Icons.image_sharp),
                  label: const Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }
}
