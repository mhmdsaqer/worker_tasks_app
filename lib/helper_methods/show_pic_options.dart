import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants.dart';

final ImagePicker _picker = ImagePicker();
Future<dynamic> showPicOptions(
    BuildContext context, File? img, Function(File) updateImage) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Choose',
          style: fieldNameStyle,
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  _getImageFromGallery(img, updateImage);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.pink.shade800,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Gallary', style: fieldNameStyle)
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  _getImageFromCamera(img, updateImage);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.pink.shade800,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Camera', style: fieldNameStyle)
                  ],
                ),
              )
            ],
          )),
        ),
      );
    },
  );
}

Future<void> _getImageFromCamera(img, updateImage) async {
  final pickedFile = await _picker.getImage(source: ImageSource.camera);

  if (pickedFile != null) {
    _getimageCropper(pickedFile!.path, img, updateImage);
  }
}

Future<void> _getImageFromGallery(img, updateImage) async {
  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    _getimageCropper(pickedFile!.path, img, updateImage);
  }
}

Future<void> _getimageCropper(pickedFilePath, img, updateImage) async {
  final croppedImage = await ImageCropper()
      .cropImage(sourcePath: pickedFilePath!, maxHeight: 1080, maxWidth: 1080);
  updateImage(croppedImage);
}
