import 'dart:io';

import 'package:ccc_task/models/work_order.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final WorkOrder workOrder;
final Function onPictureAdded;
  const DisplayPictureScreen({Key key, this.imagePath, this.workOrder, this.onPictureAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Display the Picture',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(children: [
        Image.file(File(imagePath)),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                if (workOrder.imagePaths == null) workOrder.imagePaths = [];
                workOrder.imagePaths.add(imagePath);
                Navigator.pop(context);
                onPictureAdded();
              },
              child: Text('Add to work order',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        )
      ]),
    );
  }
}
