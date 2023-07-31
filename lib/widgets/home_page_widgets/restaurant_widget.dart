import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page_image_loading_widget.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget(
      {Key? key,
      required this.restaurantName,
      required this.imageUrl,
      required this.onPressed,
      required this.rating})
      : super(key: key);
  final String restaurantName;
  final String imageUrl;
  final Function() onPressed;
  final String? rating;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: CachedNetworkImage(
                width: double.maxFinite,
                height: 150.h,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    //show a shimmer effect
                    const ImageLoadingWidget(),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.warning_rounded)),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 300.w,
              child: Center(
                child: Text(
                  restaurantName,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      rating == null
                          ? const Text('No rating')
                          : Text('$rating%'),
                      SizedBox(width: 5.w),
                      const Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 18,
                      ),
                    ],
                  ),
                  const Text('25-35 mins')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
