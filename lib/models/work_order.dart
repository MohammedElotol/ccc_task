import 'package:ccc_task/models/comment.dart';
import 'package:ccc_task/models/work_item.dart';

class WorkOrder {
  String id;
  String header;
  DateTime creationDate;
  DateTime startDate;
  DateTime endDate;
  String description;
  List<WorkItem> items;
  List<Comment> comments;
  List<String> imagePaths;

  WorkOrder(
      {this.id,
      this.header,
      this.creationDate,
      this.startDate,
      this.endDate,
      this.description,
      this.comments,
      this.imagePaths,
      this.items});

  int get progress {
    int progress = 0;
    for (var item in items) {
      progress += (item.progress / items.length).floor();
    }
    return progress;
  }

  bool isUpcoming() {
    return (startDate.compareTo(DateTime.now()) > 0 && progress == 0);
  }

  bool isCompleted() {
    return (progress == 100);
  }
}
