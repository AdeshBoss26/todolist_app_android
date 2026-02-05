import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Privacy Policy\n\n'
              '• User data is stored locally using SQLite.\n'
              '• No data is shared with third parties.\n'
              '• This application is for educational use only.\n'
              '• No internet connection is required.\n',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
