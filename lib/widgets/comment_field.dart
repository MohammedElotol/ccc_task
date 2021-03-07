import 'package:flutter/material.dart';

class CommentField extends StatefulWidget {
  final Function onChange;

  CommentField(this.onChange);

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      onChanged: (value) {
        widget.onChange(value);
        setState(() {});
      },
      decoration: InputDecoration(
          suffixIcon: controller.text.length > 0
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black.withAlpha(100),
                    size: 16,
                  ),
                )
              : null,
          hintText: 'Add a comment...',
          hintStyle:
              TextStyle(color: Colors.black.withAlpha(80), fontSize: 18)),
    );
  }
}
