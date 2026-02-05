import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Help & Support\n\n'
              '• Tap + to add a new task.\n'
              '• Tap ✓ to mark task as completed.\n'
              '• Tap delete icon to remove a task.\n'
              '• Use Settings to access app information.\n\n'
              'This app is created for academic purposes.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
