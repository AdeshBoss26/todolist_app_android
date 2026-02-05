import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;

  ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text(
          'User ID: $userId',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
