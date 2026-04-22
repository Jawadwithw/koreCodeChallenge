import 'package:flutter/material.dart';

class LoginBaseTextForm extends StatelessWidget {
  final TextEditingController _usernameController;
  final String title;
  const LoginBaseTextForm({
    super.key,
    required TextEditingController usernameController,
    required this.title,
  }) : _usernameController = usernameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _usernameController,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        hintText: title,
        filled: false,
        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
        prefixIcon: Icon(Icons.person, color: Colors.white),
      ),
    );
  }
}