import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To-Do List App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This application is developed as a college project.\n\n'
                  'Features:\n'
                  '- User Login & Registration\n'
                  '- Add, Update, Delete Tasks\n'
                  '- View Completed Tasks\n'
                  '- Profile & Settings\n'
                  '- SQLite Database\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Developed by: Student',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
