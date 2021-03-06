import 'package:ccc_task/constants.dart';
import 'package:ccc_task/models/work_order.dart';
import 'package:ccc_task/widgets/work_order_details.dart';
import 'package:flutter/material.dart';

class WorkOrdersList extends StatefulWidget {
  final List<WorkOrder> workOrders;
  final Function onWorkSelected;

  WorkOrdersList(
      this.workOrders, this.onWorkSelected(WorkOrder selectedWorkOrder));

  @override
  _WorkOrdersListState createState() => _WorkOrdersListState();
}

class _WorkOrdersListState extends State<WorkOrdersList> {
  int selectedWorkOrderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.workOrders.length,
        itemBuilder: (context, index) {
          WorkOrder workOrder = widget.workOrders[index];
          return InkWell(
            onTap: () {
              if (Constants.isWideScreen(context)) {
                widget.onWorkSelected(workOrder);
                setState(() {
                  selectedWorkOrderIndex = index;
                });
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          iconTheme: IconThemeData(
                            color: Colors.black,
                          ),
                        ),
                        body: SafeArea(
                          child: WorkOrderDetails(widget.workOrders[index],
                              (progress) {
                            setState(() {});
                          }),
                        ),
                      ),
                    ));
              }
            },
            child: Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    side: index == selectedWorkOrderIndex &&
                            Constants.isWideScreen(context)
                        ? BorderSide(width: 1, color: Colors.blue)
                        : BorderSide(
                            width: 0.5, color: Colors.black.withAlpha(20)),
                    borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.hardEdge,
                elevation: 3,
                // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shadowColor: Colors.black.withAlpha(100),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            workOrder.header,
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          workOrder.isCompleted()
                              ? Text(
                                  'Completed',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                )
                              : workOrder.isUpcoming()
                                  ? Text('Upcoming',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16))
                                  : Text('${workOrder.progress}%',
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700))
                        ],
                      ),
                      SizedBox(height: 8),
                      Visibility(
                        visible: (!workOrder.isCompleted() &&
                            !workOrder.isUpcoming()),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepOrangeAccent),
                            value: workOrder.progress / 100,
                            minHeight: 6,
                            backgroundColor: Color(0xFFdddddd),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                Constants.dateAsString(workOrder.startDate),
                                style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'End Date',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                Constants.dateAsString(workOrder.endDate),
                                style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        workOrder.description,
                        style: TextStyle(color: Color(0xFF999999)),
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
