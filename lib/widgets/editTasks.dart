import 'package:flutter/material.dart';

class EditTaskDialog extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final Function(String title, String description) onUpdate;

  EditTaskDialog({
    required this.initialTitle,
    required this.initialDescription,
    required this.onUpdate,
  });

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Task Name',
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Task Description',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // When the user clicks 'Save', call the onUpdate function with the updated values
            widget.onUpdate(
              _titleController.text,
              _descriptionController.text,
            );
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
