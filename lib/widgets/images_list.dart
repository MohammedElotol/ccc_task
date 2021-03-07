import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagesList extends StatefulWidget {
  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 80,
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
        )
      ],
    );
  }
}
