import 'package:ccc_task/models/work_item.dart';
import 'package:flutter/material.dart';

class StaticItemsList extends StatelessWidget {
  final List<WorkItem> workItems;

  StaticItemsList(this.workItems);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workItems.length,
      itemBuilder: (context, index) {
        WorkItem workItem = workItems[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  workItem.description,
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text('${workItem.progress}%',
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 22,
                        fontWeight: FontWeight.w600))
              ]),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue),
                  value: workItem.progress / 100,
                  minHeight: 6,
                  backgroundColor: Color(0xFFdddddd),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
