import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Table Example'),
        ),
        body: TableDemo(),
      ),
    );
  }
}

class TableDemo extends StatefulWidget {
  @override
  _TableDemoState createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  List<TextEditingController> cellControllers = [
    TextEditingController(text: 'Cell 1'),
    TextEditingController(text: 'Cell 2'),
    TextEditingController(text: 'Cell 3'),
    TextEditingController(text: 'Cell 4'),
    TextEditingController(text: 'Cell 5'),
    TextEditingController(text: 'Cell 6'),
    TextEditingController(text: 'Cell 7'),
    TextEditingController(text: 'Cell 8'),

  ];

  void handleEdit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Cell'),
          content: TextField(
            controller: cellControllers[index],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the cell data with edited text
                  cellControllers[index].text = cellControllers[index].text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void handleDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Cell'),
          content: Text('Are you sure you want to delete this cell?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Remove the cell controller and its associated data
                  cellControllers.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void handleInfo(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cell Info'),
          content: Text(cellControllers[index].text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Cell Data'),
            ),
            DataColumn(
              label: Text('Edit'),
            ),
            DataColumn(
              label: Text('Delete'),
            ),
            DataColumn(
              label: Text('Info'),
            ),
          ],
          rows: List<DataRow>.generate(
            cellControllers.length,
                (index) => DataRow(
              cells: [
                DataCell(
                  TextField(
                    controller: cellControllers[index],
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => handleEdit(index),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => handleDelete(index),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () => handleInfo(index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in cellControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
