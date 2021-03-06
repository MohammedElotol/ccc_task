import 'package:ccc_task/models/work_item.dart';
import 'package:ccc_task/models/work_order.dart';
import 'package:intl/intl.dart';
class Constants {
  static List<WorkOrder> workOrders = [
    WorkOrder(
        id: '111',
        header: 'Cast Concrete',
        creationDate: DateTime.now(),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 3)),
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        items: [
          WorkItem(id: '1110', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '1111', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '1112', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '1113', description: 'Lorem ipsum', progress: 0)
        ]),
    WorkOrder(
        id: '222',
        header: 'Cast Concrete 2',
        creationDate: DateTime.now(),
        startDate: DateTime.now().add(const Duration(days: 3)),
        endDate: DateTime.now().add(const Duration(days: 4)),
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        items: [
          WorkItem(id: '2220', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '2221', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '2222', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '2223', description: 'Lorem ipsum', progress: 0)
        ]),
    WorkOrder(
        id: '333',
        header: 'Cast Concrete 3',
        creationDate: DateTime.now(),
        startDate: DateTime.now().add(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 9)),
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        items: [
          WorkItem(id: '3330', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '3331', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '3332', description: 'Lorem ipsum', progress: 0),
          WorkItem(id: '3333', description: 'Lorem ipsum', progress: 0)
        ])
  ];

  static String dateAsString(DateTime dateTime){
    return DateFormat('EEE, MMM dd').format(dateTime);
  }

  static bool isUpcoming(WorkOrder workOrder){
    return (workOrder.startDate.compareTo(DateTime.now()) > 0 && workOrder.progress == 0);
  }
  static bool isCompleted(WorkOrder workOrder){
    return (workOrder.progress == 100);
  }
}