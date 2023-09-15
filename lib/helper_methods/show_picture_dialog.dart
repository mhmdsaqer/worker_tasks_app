import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/screens/register_screen.dart';

Future<dynamic> showPicDialog(BuildContext context, File? img) {
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
                onTap: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1080,
                    maxHeight: 1080,
                  );

                  if (image != null) {
                    img = File(image!.path);
                  } else {
                    return;
                  }

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
                onTap: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1080,
                    maxHeight: 1080,
                  );

                  if (image != null) {
                    img = File(image!.path);
                  } else {
                    return;
                  }

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
