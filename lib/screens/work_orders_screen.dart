import 'package:ccc_task/constants.dart';
import 'package:ccc_task/models/work_order.dart';
import 'package:ccc_task/screens/filter_screen.dart';
import 'package:ccc_task/widgets/work_order_details.dart';
import 'package:ccc_task/widgets/work_orders_list.dart';
import 'package:flutter/material.dart';

class WorkOrdersScreen extends StatefulWidget {
  @override
  _WorkOrdersScreenState createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  WorkOrder selectedWorkOrder;
  List<String> selectedFilter = [];
  List<WorkOrder> filteredWorkOrders = Constants.workOrders;

  @override
  void initState() {
    selectedWorkOrder = Constants.workOrders.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OrientationBuilder(
        builder: (context, orientation) {
          if (Constants.isWideScreen(context)) {
            return Scaffold(
              body: SafeArea(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: WorkOrdersList(Constants.workOrders,
                              (selectedWO) {
                            setState(() {
                              selectedWorkOrder = selectedWO;
                            });
                          })),
                      Expanded(
                          flex: 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.5,
                                    color: Colors.black.withAlpha(20)),
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.hardEdge,
                            elevation: 3,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            shadowColor: Colors.black.withAlpha(100),
                            child:
                                WorkOrderDetails(selectedWorkOrder, (progress) {
                              setState(() {});
                            }),
                          ))
                    ]),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                  title: Text(
                    'Work Orders',
                    style: TextStyle(color: Colors.black),
                  ),
                // actions: [
                //   GestureDetector(
                //     onTap: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => FilterScreen(
                //             selectedFilter,
                //             onFilterApplied: (selectedFilter) {
                //               setState(() {
                //                 this.selectedFilter = selectedFilter;
                //               });
                //             },
                //           ),
                //         )),
                //     child: Row(
                //       children: [
                //         Icon(Icons.filter_alt_outlined,
                //             color: Colors.blue, size: 16),
                //         Text('Filter',
                //             style: TextStyle(
                //                 color: Colors.blue,
                //                 fontWeight: FontWeight.w500)),
                //         SizedBox(width: 16)
                //       ],
                //     ),
                //   )
                // ],
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WorkOrdersList(Constants.workOrders, (selectedWO) {
                  setState(() {
                    selectedWorkOrder = selectedWO;
                  });
                }),
              )),
            );
          }
        },
      ),
    );
  }
}
