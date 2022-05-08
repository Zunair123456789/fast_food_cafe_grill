// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MenuImagePicker extends StatefulWidget {
  const MenuImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuImagePicker> createState() => _MenuImagePickerState();
}

class _MenuImagePickerState extends State<MenuImagePicker> {
  // ignore: unused_field
  File? _pickedImage;
  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null),
        Center(
          child: TextButton.icon(
            icon: const Icon(Icons.image),
            label: const Text('Add image'),
            onPressed: () {
              _pickImage();
            },
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
