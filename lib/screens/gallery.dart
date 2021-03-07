import 'dart:io';

import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final List<String> pictures;
  final int initialPage;

  Gallery(this.pictures, this.initialPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Dismissible(
            direction: DismissDirection.vertical,
            key: const Key('key'),
            onDismissed: (_) => Navigator.of(context).pop(),
            child: SizedBox.expand(
              child: Container(
                color: Colors.black,
                child: PageView(
                    controller: PageController(
                        initialPage: initialPage,
                        keepPage: true,
                        viewportFraction: 1),
                    scrollDirection: Axis.horizontal,
                    children: pictures
                        .map(
                          (picture) => picture.contains('http')
                              ? Image.network(
                                  picture,
                                  width: double.maxFinite,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.file(
                                  File(picture),
                                  width: double.maxFinite,
                                  fit: BoxFit.fitWidth,
                                ),
                        )
                        .toList()),
              ),
            )),
      ),
    );
  }
}
