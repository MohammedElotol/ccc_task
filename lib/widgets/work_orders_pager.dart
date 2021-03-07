import 'package:ccc_task/constants.dart';
import 'package:ccc_task/screens/gallery.dart';
import 'package:ccc_task/widgets/work_order_details.dart';
import 'package:flutter/material.dart';

class WorkOrdersPager extends StatefulWidget {
  @override
  _WorkOrdersPagerState createState() => _WorkOrdersPagerState();
}

class _WorkOrdersPagerState extends State<WorkOrdersPager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Gallery(Constants.workOrders.first.imagePaths, 0),
            PageView.builder(
                itemCount: Constants.workOrders.length,
                onPageChanged: (value) {

                },
                itemBuilder: (context, index) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.2,
                    minChildSize: 0.2,
                    maxChildSize: 0.7,
                    builder: (context, scrollController) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5,
                                color: Colors.black.withAlpha(20)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        clipBehavior: Clip.hardEdge,
                        elevation: 3,
                        shadowColor: Colors.black.withAlpha(100),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: WorkOrderDetails(
                              Constants.workOrders[index], (progress) {}),
                        ),
                      );
                    },
                  );
                },
                controller: PageController(
                  viewportFraction: 0.8,
                  initialPage: 0,
                )),
          ],
        ),
      ),
    );
  }
}
