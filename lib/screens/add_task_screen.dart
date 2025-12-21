import 'package:flutter/material.dart';
import 'package:todo_sqlite_app/db/database_helper.dart';
import 'package:todo_sqlite_app/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final int userId;
  AddTaskScreen({required this.userId});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void _saveTask() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task title is required')),
      );
      return;
    }

    final task = Task(userId: widget.userId, title: title, description: desc);
    await DatabaseHelper().insertTask(task.toMap());

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
