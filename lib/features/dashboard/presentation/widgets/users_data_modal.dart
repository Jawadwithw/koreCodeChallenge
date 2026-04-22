import 'package:flutter/material.dart';

class UsersDataModalWidget extends StatefulWidget {
  final dynamic users;

  final VoidCallback onUpdate;
  const UsersDataModalWidget({super.key, this.users, required this.onUpdate});

  @override
  State<UsersDataModalWidget> createState() => _UsersDataModalWidgetState();
}

class _UsersDataModalWidgetState extends State<UsersDataModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.users[index]['name']),
            subtitle: Text('Age: ${widget.users[index]['age']}'),
            trailing: Switch(
              value: widget.users[index]['is_active'],
              activeColor: Color(0xFF0F8F83),
              onChanged: (value) {
 
                widget.users[index]['is_active'] = value;
                setState(() {});
                widget.onUpdate();
              },
            ),
          );
        },
      ),
    );
  }
}
