import 'package:ccc_task/widgets/status_filter.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<String> types = ['Upcoming', 'In Progress', 'Completed'];
  List<String> selectedTypes = [];
  final Function(List<String>) onFilterApplied;

  FilterScreen(this.selectedTypes, {this.onFilterApplied});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> tempSelectedTypes = [];

  @override
  void initState() {
    tempSelectedTypes = List.from(widget.selectedTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Filter',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          TextButton(
              onPressed: () {
                widget.selectedTypes = [];
                widget.onFilterApplied(widget.selectedTypes);
                Navigator.pop(context);
              },
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                widget.selectedTypes = tempSelectedTypes;
                widget.onFilterApplied(widget.selectedTypes);
                Navigator.pop(context);
              },
              child: Text(
                'Apply',
                style: TextStyle(color: Colors.black),
              )),
          SizedBox(width: 12)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            StatusFilter(
              tempSelectedTypes,
              onSelectionChanged: (selectedList) {
                setState(() {
                  tempSelectedTypes = selectedList;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
