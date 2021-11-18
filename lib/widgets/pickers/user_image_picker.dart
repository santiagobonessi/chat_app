import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePick;

  const UserImagePicker(this.imagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePick(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          foregroundColor: Theme.of(context).accentColor,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
          ),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
