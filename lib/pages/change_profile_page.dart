import 'dart:io';

import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/picture_select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  //File _imageFile = File('assets/images/profile.png');
  //XFile? _photoFile = XFile('');
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
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    // if (result != null) {
    //   setState(() {
    //     _imageFile = File(result.files.single.path ?? '');
    //   });
    // }
    // final blocProviderState = BlocProvider.of<UserBloc>(context).;

    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      //blocProviderState.photoFile = pickedImage;
      if (!mounted) return;
      context
          .read<UserBloc>()
          .add(ChangeProfilePictureEvent(photoFile: pickedImage));
      //print(_photoFile!.path.toString());
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
                            context: context,
                            builder: (context) => PictureSelectBottomSheet(
                                  onPressedCamera: () {
                                    takePhoto(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  onPressedGallery: () {
                                    takePhoto(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ));
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: state.photoFile == null ||
                                    state.photoFile!.path.isEmpty
                                ? const AssetImage('assets/images/profile.png')
                                    as ImageProvider
                                : FileImage(
                                    File(state.photoFile!.path)), //Image.file()
                          ),
                          const Positioned(
                              bottom: 20,
                              right: 20,
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
                      onPressed: () {
                        File file = File(state.photoFile!.path);
                        String filename = file.path.split('/').last;

                        String filepath = file.path;

                        ApiServices().postProfilePic(
                            filepath, filename, state.userToken);
                        print('FileName: $filename, FilePath: $filepath');
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('Save'),
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
