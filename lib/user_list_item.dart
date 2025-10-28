import 'package:flutter/material.dart';
import 'user_model.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserListItem({super.key, required this.user, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Hero(
            tag: 'avatar-${user.id}',
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 28,
            ),
          ),
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
          ),
          subtitle: Text(
            user.email,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600], fontSize: 14),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit, color: Colors.blueGrey), onPressed: onEdit),
              IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}