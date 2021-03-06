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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.comments.length,
      itemBuilder: (context, index) {
        Comment comment = widget.comments[index];
        return Column(
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
            SizedBox(height: 16)
          ],
        );
      },
    );
  }
}
