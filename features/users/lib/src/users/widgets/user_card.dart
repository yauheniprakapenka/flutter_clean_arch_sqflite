import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final User user;

  const UserCard({
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      color: Colors.deepPurple[100],
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(user.firstName),
          TextButton(onPressed: onDeletePressed, child: const Icon(Icons.delete, color: Colors.red)),
          TextButton(onPressed: onEditPressed, child: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
