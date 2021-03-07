import 'dart:math';

import 'package:ccc_task/models/comment.dart';
import 'package:ccc_task/models/work_item.dart';
import 'package:ccc_task/models/work_order.dart';
import 'package:ccc_task/widgets/comment_field.dart';
import 'package:ccc_task/widgets/comments_list.dart';
import 'package:ccc_task/widgets/images_list.dart';
import 'package:ccc_task/widgets/slider_widget.dart';
import 'package:ccc_task/widgets/static_items_list.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class WorkOrderDetails extends StatefulWidget {
  final WorkOrder workOrder;
  final Function onProgressUpdate;

  WorkOrderDetails(this.workOrder, this.onProgressUpdate(progress));

  @override
  _WorkOrderDetailsState createState() => _WorkOrderDetailsState();
}

class _WorkOrderDetailsState extends State<WorkOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.black.withAlpha(20)),
          borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shadowColor: Colors.black.withAlpha(100),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.workOrder.header,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 8),
                    statusWidget(),
                    SizedBox(height: 16),
                    Text(
                      '${Constants.dateAsString(widget.workOrder.startDate)} - ${Constants.dateAsString(widget.workOrder.endDate)}',
                      style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.workOrder.description,
                      style: TextStyle(height: 1.5, color: Color(0xFF999999)),
                    ),
                    SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: Color(0xFF333333), size: 18),
                          onPressed: () {
                            updateItemsDialog((workItem) {
                              setState(() {
                                widget.workOrder.items = workItem;
                              });
                              widget
                                  .onProgressUpdate(widget.workOrder.progress);
                            });
                          },
                        ),
                      ],
                    ),
                    StaticItemsList(widget.workOrder.items),
                    SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Photos',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    ImagesList(),
                    SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 16),
                    Visibility(
                      visible: widget.workOrder.comments != null &&
                          widget.workOrder.comments.isNotEmpty,
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_comment_outlined,
                            color: Color(0xFF333333),
                            size: 15,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Comments',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    CommentsList(widget.workOrder.comments),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        addCommentDialog((commentText) {
                          setState(() {
                            if(widget.workOrder.comments == null) widget.workOrder.comments = [];
                            widget.workOrder.comments.add(Comment(
                                id: Random().nextInt(100).toString(),
                                text: commentText,
                                createdAt: DateTime.now()));
                          });
                        });
                      },
                      child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              border: Border.all(color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            'Add a comment...',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff666666)),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusWidget() {
    if (Constants.isCompleted(widget.workOrder)) {
      //complete
      return Text(
        '100% completed',
        style: TextStyle(color: Colors.green, fontSize: 16),
      );
    } else if (Constants.isUpcoming(widget.workOrder)) {
      // upcoming
      return Text(
        'Upcoming',
        style: TextStyle(color: Colors.blue, fontSize: 16),
      );
    } else {
      // in progress
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${widget.workOrder.progress}% complete',
          style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: SizedBox(
            width: 180,
            child: LinearProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
              value: widget.workOrder.progress / 100,
              minHeight: 6,
              backgroundColor: Color(0xFFdddddd),
            ),
          ),
        ),
      ]);
    }
  }

  updateItemsDialog(onApplyChanges(workItems)) {
    List<WorkItem> itemsClone = List<WorkItem>.from(widget.workOrder.items);
    showDialog<void>(
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              actionsPadding: EdgeInsets.all(16),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onApplyChanges(itemsClone);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
              ],
              content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemsClone.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                itemsClone[index].description,
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text('${itemsClone[index].progress}%',
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600))
                            ]),
                        SizedBox(height: 4),
                        SliderWidget(itemsClone[index], (value) {
                          itemsClone[index].progress = value;
                        }),
                        SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ));
        },
        context: context);
  }

  addCommentDialog(onAddComment(comment)) {
    String commentText = '';
    showDialog<void>(
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              actionsPadding: EdgeInsets.only(right: 16),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onAddComment(commentText);
                      // onAddComment(comment);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
              ],
              content: Container(
                  width: 300,
                  child: CommentField((text) => commentText = text)));
        },
        context: context);
  }
}
