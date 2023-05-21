import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(15),
          width: double.maxFinite,
          height: 150.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: CachedNetworkImage(
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  imageUrl: state.photoUrl ?? '',
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/profile.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.name ?? 'null',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    state.email ?? 'null',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Divider(
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                  Text(
                    state.phone ?? 'null',
                    style: TextStyle(
                      height: 1,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Divider(
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                  Text(
                    state.address ?? 'null',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
