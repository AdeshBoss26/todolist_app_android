import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'completed_tasks_screen.dart';
import 'package:todo_sqlite_app/db/database_helper.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final data =
    await DatabaseHelper().getTasks(widget.userId, completed: false);
    setState(() {
      tasks = data;
    });
  }

  void _markAsDone(int id) async {
    await DatabaseHelper().updateTask(id, {'isDone': 1});
    _loadTasks();
  }

  void _deleteTask(int id) async {
    await DatabaseHelper().deleteTask(id);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CompletedTasksScreen(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task['title']),
            subtitle: Text(task['description'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.done, color: Colors.green),
                  onPressed: () => _markAsDone(task['id']),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(task['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(userId: widget.userId),
            ),
          ).then((_) => _loadTasks());
        },
      ),
    );
  }
}
