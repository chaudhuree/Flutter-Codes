import 'package:flutter/material.dart';

import '../databaseHelper.dart';
import '../models/todo.dart';
import '../models/user.dart';

class ListTasksPage extends StatefulWidget {
  const ListTasksPage({super.key});

  @override
  State<ListTasksPage> createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  late Future<List<User>> _usersFuture;
  Map<int, Future<List<Todo>>> _todosFutures = {};

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _usersFuture = DatabaseHelper.instance.getUsers();
  }

  void _loadTodosForUser(int userId) {
    _todosFutures[userId] = DatabaseHelper.instance.getTodosByUser(userId);
  }

  Future<void> _deleteTask(int id, int userId) async {
    await DatabaseHelper.instance.deleteTodo(id);
    setState(() {
      _loadTodosForUser(userId);
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task deleted')));
    }
  }

  Future<void> _updateTaskCompleted(int id, bool completed, int userId) async {
    await DatabaseHelper.instance.updateTodoCompleted(id, completed);
    setState(() {
      _loadTodosForUser(userId);
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(completed ? 'Task completed' : 'Task uncompleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: \\${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        } else {
          List<User> users = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for (final user in users)
                FutureBuilder<List<Todo>>(
                  future: _todosFutures[user.id!] ??= DatabaseHelper.instance
                      .getTodosByUser(user.id!),
                  builder: (context, todoSnapshot) {
                    if (todoSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (todoSnapshot.hasError) {
                      return Center(
                        child: Text('Error: \\${todoSnapshot.error}'),
                      );
                    } else if (!todoSnapshot.hasData ||
                        todoSnapshot.data!.isEmpty) {
                      return Container();
                    } else {
                      List<Todo> todos = todoSnapshot.data!;
                      return Column(
                        children: todos.map((todo) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Dismissible(
                              key: ValueKey(todo.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Task'),
                                    content: const Text(
                                      'Are you sure you want to delete this task?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onDismissed: (direction) {
                                _deleteTask(todo.id!, user.id!);
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: todo.completed
                                      ? Colors.green[50]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: todo.completed
                                        ? Colors.green
                                        : Colors.grey.shade300,
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.08),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        top: 12,
                                      ),
                                      child: Checkbox(
                                        value: todo.completed,
                                        onChanged: (bool? value) {
                                          _updateTaskCompleted(
                                            todo.id!,
                                            value ?? false,
                                            user.id!,
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        activeColor: Colors.amber[900],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              todo.title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: todo.completed
                                                    ? Colors.green[900]
                                                    : Colors.black87,
                                                decoration: todo.completed
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  user.name,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
            ],
          );
        }
      },
    );
  }
}
