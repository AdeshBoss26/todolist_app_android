import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Contact Information\n\n'
              'Developer Name: Student\n'
              'College: XYZ College\n'
              'Email: student@example.com\n'
              'Phone: +91 9000000000\n\n'
              'This app is a college project.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
