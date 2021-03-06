import 'package:ccc_task/constants.dart';
import 'package:ccc_task/models/work_order.dart';
import 'package:ccc_task/widgets/work_order_details.dart';
import 'package:ccc_task/widgets/work_orders_list.dart';
import 'package:flutter/material.dart';

class WorkOrdersScreen extends StatefulWidget {
  @override
  _WorkOrdersScreenState createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  WorkOrder selectedWorkOrder;

  @override
  void initState() {
    selectedWorkOrder = Constants.workOrders.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return Row(children: [
                  Expanded(flex:4,child: WorkOrdersList(Constants.workOrders, (selectedWO){
                    setState(() {
                      selectedWorkOrder = selectedWO;
                    });
                  })),
                  Expanded(flex:5,child: WorkOrderDetails(selectedWorkOrder, (progress){
                    setState(() {
                    });
                  }))
                ]);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
