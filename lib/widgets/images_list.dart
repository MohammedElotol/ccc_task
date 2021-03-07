import 'dart:io';

import 'package:ccc_task/models/work_order.dart';
import 'package:ccc_task/screens/gallery.dart';
import 'package:ccc_task/screens/take_picture_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';

class ImagesList extends StatefulWidget {
  final WorkOrder workOrder;

  ImagesList(this.workOrder);

  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  final double viewHeight = 120;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: viewHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                final cameras = await availableCameras();
                final firstCamera = cameras.first;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                              camera: firstCamera,
                              workOrder: widget.workOrder,
                              onPictureAdded: () {
                                setState(() {});
                              },
                            )));
              },
              child: SizedBox(
                width: 80,
                height: viewHeight,
                child: DottedBorder(
                  color: Colors.black.withAlpha(100),
                  dashPattern: [6, 4, 6, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/camera.svg',
                      color: Colors.blue,
                      width: 25,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.workOrder.imagePaths.length,
              itemBuilder: (context, index) {
                String imagePath = widget.workOrder.imagePaths[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Gallery(widget.workOrder.imagePaths, index)));
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imagePath.contains('http')
                              ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: viewHeight,
                                )
                              : Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: viewHeight,
                                ))),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
