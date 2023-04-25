import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/picture_select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({Key? key}) : super(key: key);
  static const id = 'change_profile_page';

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void takePhoto(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage == null) return null;
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      //compressQuality: 70,
      //compressFormat: ImageCompressFormat.jpg,
    );
    if (croppedImage != null) {
      if (!mounted) return;
      context.read<UserBloc>().add(ClearPhotoFileEvent());
      context
          .read<UserBloc>()
          .add(ChangeProfilePictureEvent(photoFile: XFile(croppedImage.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  topLeft: Radius.circular(10.r)),
                            ),
                            context: context,
                            builder: (context) => PictureSelectBottomSheet(
                                  onPressedCamera: () {
                                    takePhoto(ImageSource.camera);
                                  },
                                  onPressedGallery: () {
                                    takePhoto(ImageSource.gallery);
                                  },
                                ));
                      },
                      child: Stack(
                        children: [
                          state.photoUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(200.r),
                                  child: CachedNetworkImage(
                                    width: 200.w,
                                    //height: 00.h,
                                    fit: BoxFit.cover,
                                    imageUrl: state.photoUrl!,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/profile.png'),
                                  ),

                                  // state.photoFile == null || state.photoFile!.path.isEmpty
                                  //     ? const AssetImage('assets/images/profile.png')
                                  //         as ImageProvider
                                  //     : FileImage(File(state.photoFile!.path)), //Image.file()
                                )
                              : CircleAvatar(
                                  radius: 80.r,
                                  backgroundImage: state.photoFile == null ||
                                          state.photoFile!.path.isEmpty
                                      ? const AssetImage(
                                              'assets/images/profile.png')
                                          as ImageProvider
                                      : FileImage(File(state
                                          .photoFile!.path)), //Image.file()
                                ),
                          const Positioned(
                              bottom: 20,
                              right: 35,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black38,
                              ))
                        ],
                      )),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _nameController,
                    //initialValue: state.name,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name field is required';
                      }
                      if (value.length < 2 || value.length > 15) {
                        return 'Name must be between 2 and 15 characters long';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _phoneController,
                    //initialValue: state.phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone field required';
                      }
                      if (value.length > 14 || value.length < 11) {
                        return 'Invalid phone number format';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address field required';
                      }
                      if (value.length < 5) {
                        return 'Invalid address';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () async {
                        File file = File(state.photoFile!.path);
                        // print('token: ${state.userToken}');
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ));
                        await context
                            .read<ApiServices>()
                            .postProfilePic(file, state.userToken)
                            .then((value) {
                          context
                              .read<UserBloc>()
                              .add(AddPhotoUrlEvent(photoUrl: value.photoUrl));
                          context.read<UserBloc>().add(GetUserEvent());
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                        // await ApiServices()
                        //     .postProfilePic(file, state.userToken)
                        //     .then((value) => context.read<UserBloc>().add(
                        //           AddPhotoUrlEvent(photoUrl: value),
                        //         ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: const Text('Save'),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
