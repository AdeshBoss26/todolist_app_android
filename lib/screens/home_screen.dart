import 'package:flutter/material.dart';
import 'package:todo_sqlite_app/db/database_helper.dart';
import 'package:todo_sqlite_app/screens/add_task_screen.dart';
import 'package:todo_sqlite_app/screens/completed_tasks_screen.dart';
import 'package:todo_sqlite_app/screens/profile_screen.dart';
import 'package:todo_sqlite_app/screens/settings_screen.dart';
import 'package:todo_sqlite_app/screens/task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
        title: const Text('My Tasks'),
        actions: [
          // PROFILE
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(userId: widget.userId),
                ),
              );
            },
          ),

          // SETTINGS
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(),
                ),
              );
            },
          ),

          // COMPLETED TASKS
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CompletedTasksScreen(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),

      body: tasks.isEmpty
          ? const Center(child: Text('No tasks added'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return ListTile(
            title: Text(task['title']),
            subtitle: Text(task['description'] ?? ''),

            // ✅ TASK DETAILS (FIXED)
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskDetailsScreen(
                    title: task['title'],
                    description: task['description'] ?? '',
                  ),
                ),
              );
            },

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:
                  const Icon(Icons.done, color: Colors.green),
                  onPressed: () => _markAsDone(task['id']),
                ),
                IconButton(
                  icon:
                  const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(task['id']),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
