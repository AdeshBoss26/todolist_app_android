import 'package:flutter/material.dart';
import 'package:todo_sqlite_app/db/database_helper.dart';

class CompletedTasksScreen extends StatefulWidget {
  final int userId;
  CompletedTasksScreen({required this.userId});

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  void _loadCompletedTasks() async {
    final data =
    await DatabaseHelper().getTasks(widget.userId, completed: true);
    setState(() {
      tasks = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task['title']),
            subtitle: Text(task['description'] ?? ''),
          );
        },
      ),
    );
  }
}
