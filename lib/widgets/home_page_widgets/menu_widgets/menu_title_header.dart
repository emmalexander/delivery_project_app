import 'package:delivery_project_app/consts/global_constants.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuTitleHeader extends StatelessWidget {
  const MenuTitleHeader(
      {Key? key,
      required this.restaurantName,
      required this.available,
      required this.rating,
      required this.like,
      required this.restaurantId,
      required this.token})
      : super(key: key);
  final String restaurantName;
  final bool available;
  final String? rating;
  final LikeStatus like;
  final String restaurantId;
  final String token;

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
                color: available ? Colors.green : Colors.redAccent,
                size: 15,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: like == LikeStatus.Liked
                        ? const Icon(
                            Icons.thumb_down_outlined,
                            size: 20,
                          )
                        : like == LikeStatus.Disliked
                            ? const Icon(
                                Icons.thumb_down,
                                size: 20,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.thumb_down_outlined,
                                size: 20,
                              ),
                    onPressed: () {
                      //debugPrint(restaurantId);
                      if (like == LikeStatus.NotRated) {
                        context
                            .read<ApiServices>()
                            .rateRestaurant(
                              like: false,
                              restaurantId: restaurantId,
                              token: token,
                            )
                            .then((value) {
                          debugPrint(value.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: 'You already rated this Restaurant',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green.withOpacity(.3),
                            textColor:
                                Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 16.0);
                      }
                    },
                  ),
                  rating == null ? const Text('No rating') : Text('$rating%'),
                  SizedBox(width: 5.w),
                  IconButton(
                    icon: like == LikeStatus.Liked
                        ? const Icon(
                            Icons.thumb_up_rounded,
                            size: 20,
                            color: Colors.green,
                          )
                        : like == LikeStatus.Disliked
                            ? const Icon(
                                Icons.thumb_up_outlined,
                                size: 20,
                              )
                            : const Icon(
                                Icons.thumb_up_outlined,
                                size: 20,
                              ),
                    onPressed: () {
                      if (like == LikeStatus.NotRated) {
                        context
                            .read<ApiServices>()
                            .rateRestaurant(
                              like: true,
                              restaurantId: restaurantId,
                              token: token,
                            )
                            .then((value) {
                          debugPrint(value.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: 'You already rated this Restaurant',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green.withOpacity(.3),
                            textColor:
                                Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 16.0);
                      }
                    },
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
