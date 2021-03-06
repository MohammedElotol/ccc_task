import 'package:ccc_task/models/work_item.dart';

class WorkOrder{
  String id;
  String header;
  DateTime creationDate;
  DateTime startDate;
  DateTime endDate;
  String description;
  List<WorkItem> items;

  WorkOrder(
      {this.id,
        this.header,
      this.creationDate,
      this.startDate,
      this.endDate,
      this.description,
      this.items});

  int get progress{
    int progress = 0;
    for(var item in items){
      progress += (item.progress / items.length).floor();
    }
    return progress;
  }
}