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
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://media.gcflearnfree.org/content/55e0730c7dd48174331f5164_01_17_2014/whatisacomputer_hardware.jpg",
                  placeholder: (context, url) => SizedBox(
                      height: 17.h,
                      width: 17.w,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                // state.photoFile == null || state.photoFile!.path.isEmpty
                //     ? const AssetImage('assets/images/profile.png')
                //         as ImageProvider
                //     : FileImage(File(state.photoFile!.path)), //Image.file()
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
