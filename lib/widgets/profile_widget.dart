import 'dart:io';

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
          padding: const EdgeInsets.all(20),
          width: double.maxFinite,
          height: 200.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage:
                    state.photoFile == null || state.photoFile!.path.isEmpty
                        ? const AssetImage('assets/images/profile.png')
                            as ImageProvider
                        : FileImage(File(state.photoFile!.path)), //Image.file()
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emmanuel Reo',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'emmanuelohiocheoya@gmail.com',
                    style: TextStyle(
                      height: 1,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Divider(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    '09031887457',
                    style: TextStyle(
                      height: 1,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Divider(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  Text(
                    'Ojodu, Lagos',
                    style: TextStyle(
                      height: 1,
                      color: Colors.black.withOpacity(.5),
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
