import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem item;
  final void Function(String, bool) onEdit;
  final void Function(String) onRemove;

  const TodoListItem(
      {super.key,
      required this.item,
      required this.onEdit,
      required this.onRemove});

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(
          item.text,
          style: TextStyle(
              decoration: item.done ? TextDecoration.lineThrough : null),
        ),
        leading: Checkbox(
          value: item.done,
          onChanged: (value) => onEdit(item.id, value ?? false),
        ),
        trailing: IconButton(
          onPressed: () => onRemove(item.id),
          icon: const Icon(Icons.delete),
        ),
      );
}
