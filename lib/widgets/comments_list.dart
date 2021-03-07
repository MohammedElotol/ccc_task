import 'package:ccc_task/constants.dart';
import 'package:ccc_task/models/comment.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatefulWidget {
  final List<Comment> comments;

  CommentsList(this.comments);

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.comments != null && widget.comments.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          Comment comment = widget.comments[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 4, bottom: 12, left: 8, right: 12),
                decoration: BoxDecoration(
                    color: Color(0xFFedf8fc),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Constants.dateTimeAsString(comment.createdAt),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF666666)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      comment.text,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16)
            ],
          );
        },
      );
    } else {
      return SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.mode_comment_outlined,
              size: 40,
              color: Color(0xFF999999),
            ),
            SizedBox(height: 12),
            Text(
              'No Comments',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF999999),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12),
          ],
        ),
      );
    }
  }
}
