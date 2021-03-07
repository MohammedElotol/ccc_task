import 'package:flutter/material.dart';

class StatusFilter extends StatefulWidget {
  final List<String> types = ['Upcoming', 'In Progress', 'Completed'];
  final List<String> selectedChoices;
  final Function(List<String>) onSelectionChanged;

  StatusFilter(this.selectedChoices, {this.onSelectionChanged});

  @override
  _StatusFilterState createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.types.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Color(0xffefefef),
          label: Text(item),
          selected: widget.selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              widget.selectedChoices.contains(item)
                  ? widget.selectedChoices.remove(item)
                  : widget.selectedChoices.add(item);
              widget.onSelectionChanged(widget.selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE1E5E9), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Status',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(children: _buildChoiceList()),
            ),
          ],
        ),
      ),
    );
  }
}
