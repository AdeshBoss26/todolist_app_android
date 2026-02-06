import 'package:flutter/material.dart';
import 'package:todo_sqlite_app/db/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final user = await DatabaseHelper().getUserById(widget.userId);
    if (user != null) {
      setState(() {
        username = user['username'];
        _controller.text = username;
      });
    }
  }

  void _updateProfile() async {
    await DatabaseHelper().updateUser(widget.userId, _controller.text.trim());
    _loadUser();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.person, size: 80),
            const SizedBox(height: 20),

            Text(
              'User ID: ${widget.userId}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
