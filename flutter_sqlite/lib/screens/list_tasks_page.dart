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
  Set<int> _expandedUsers = {};

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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        } else {
          List<User> users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return FutureBuilder<List<Todo>>(
                future: _todosFutures[user.id!] ??= DatabaseHelper.instance
                    .getTodosByUser(user.id!),
                builder: (context, todoSnapshot) {
                  if (todoSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (todoSnapshot.hasError) {
                    return Center(child: Text('Error: ${todoSnapshot.error}'));
                  } else if (!todoSnapshot.hasData ||
                      todoSnapshot.data!.isEmpty) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('${user.name}\'s Tasks'),
                        subtitle: const Text('No tasks'),
                      ),
                    );
                  } else {
                    List<Todo> todos = todoSnapshot.data!;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: _expandedUsers.contains(user.id),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            if (expanded) {
                              _expandedUsers.add(user.id!);
                            } else {
                              _expandedUsers.remove(user.id!);
                            }
                          });
                        },
                        leading: const Icon(Icons.person),
                        title: Text('${user.name}\'s Tasks'),
                        children: todos.map((Todo todo) {
                          return ListTile(
                            leading: const Icon(Icons.task),
                            title: Text(todo.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
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
                                    ), // 👈 rounded
                                  ),
                                  activeColor: Colors.amber[900],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _deleteTask(todo.id!, user.id!),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
