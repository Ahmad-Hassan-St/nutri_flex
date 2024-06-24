import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../models/chat_user.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size; // MediaQuery to get screen size

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Padding(
            padding: const EdgeInsets.only(left: 43.0),
            child: Text("Profile Screen",style: Theme.of(context).textTheme.displayLarge,),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: mq.height * 0.03),

                  // User profile picture section
                  Stack(
                    children: [
                      // Profile picture display
                      _buildProfilePicture(mq),

                      // Edit image button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () => _showBottomSheet(),
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // User email display
                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // Name input field
                  _buildTextField(
                    label: 'Name',
                    initialValue: widget.user.name,
                    onSave: (val) => APIs.me.name = val ?? '',
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // About input field
                  _buildTextField(
                    label: 'About',
                    initialValue: widget.user.about,
                    onSave: (val) => APIs.me.about = val ?? '',
                  ),

                  SizedBox(height: mq.height * 0.02),

                  // Update profile button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const StadiumBorder(),
                      minimumSize: Size(mq.width * 0.5, mq.height * 0.06),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, 'Profile Updated Successfully!');
                        });
                      }
                    },
                    icon: const Icon(Icons.edit, size: 22,color: Colors.white,),
                    label:  Text('UPDATE', style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 17
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture(Size mq) {
    return Stack(
      children: [
        // Profile picture display
        _image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(mq.height * 0.1),
          child: Image.file(
            File(_image!),
            width: mq.height * 0.2,
            height: mq.height * 0.2,
            fit: BoxFit.cover,
          ),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(mq.height * 0.1),
          child: CachedNetworkImage(
            width: mq.height * 0.2,
            height: mq.height * 0.2,
            fit: BoxFit.cover,
            imageUrl: widget.user.image,
            placeholder: (context, url) => const CircleAvatar(
              child: Icon(CupertinoIcons.person),
            ),
            errorWidget: (context, url, error) => const CircleAvatar(
              child: Icon(CupertinoIcons.person),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String? initialValue,
    required Function(String?) onSave,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        initialValue: initialValue,
        onSaved: onSave,
        validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
        decoration: InputDecoration(
          prefixIcon: Icon(
            label == 'Name' ? Icons.person : Icons.info_outline,
            color: Colors.blue,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: 'eg. ${label == 'Name' ? 'Happy Singh' : 'Feeling Happy'}',
          labelText: label,
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        final mq = MediaQuery.of(context).size;

        return Padding(
          padding: EdgeInsets.only(top: mq.height * 0.03, bottom: mq.height * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: mq.height * 0.02),

              // Buttons to pick image from gallery or camera
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                    ),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Image.asset('assets/images/add_image.png',height: 50,width: 50,),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                    ),
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Image.asset('assets/images/camera.png',height: 50,width: 50,),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      log('Image Path: ${image.path}');
      setState(() {
        _image = image.path;
      });

      APIs.updateProfilePicture(File(_image!));

      Navigator.pop(context); // Close bottom sheet
    }
  }
}
