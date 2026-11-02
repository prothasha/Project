
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  static const Color burgundy = Color(0xFF702D45);
  static const Color rosePink = Color(0xFFB85C75);
  static const Color blush = Color(0xFFF8E9ED);
  static const Color ivory = Color(0xFFFFFDF8);
  static const Color darkText = Color(0xFF29232A);
  static const Color mutedText = Color(0xFF7E5965);

  final TextEditingController taskController = TextEditingController();

  final List<Map<String, dynamic>> tasks = [];

  void showTaskDialog({int? index}) {
    taskController.text = index == null ? '' : tasks[index]['title'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ivory,
          title: Text(
            index == null ? 'Add New Task' : 'Edit Task',
            style: const TextStyle(
              color: burgundy,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: taskController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter your task',
              filled: true,
              fillColor: blush,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: mutedText),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String task = taskController.text.trim();

                if (task.isEmpty) {
                  return;
                }

                setState(() {
                  if (index == null) {
                    tasks.add({
                      'title': task,
                      'completed': false,
                    });
                  } else {
                    tasks[index]['title'] = task;
                  }
                });

                taskController.clear();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: burgundy,
                foregroundColor: Colors.white,
              ),
              child: Text(index == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        backgroundColor: burgundy,
      ),
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int completedTasks =
        tasks.where((task) => task['completed'] == true).length;

    int pendingTasks = tasks.length - completedTasks;

    return Scaffold(
      backgroundColor: blush,
      appBar: AppBar(
        title: const Text(
          'My To-Do List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: burgundy,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Stay Organized!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${tasks.length} Total Tasks',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _buildCountCard(
                      'Pending',
                      pendingTasks,
                      Icons.pending_actions_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCountCard(
                      'Completed',
                      completedTasks,
                      Icons.task_alt_rounded,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Tasks',
                  style: TextStyle(
                    color: burgundy,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 65,
                            color: rosePink.withValues(alpha: 0.7),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No tasks yet!',
                            style: TextStyle(
                              color: burgundy,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Add a task to get started.',
                            style: TextStyle(color: mutedText),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 5,
                      ),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        bool isCompleted =
                            tasks[index]['completed'] == true;

                        return Card(
                          color: ivory,
                          elevation: 1,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            leading: Checkbox(
                              value: isCompleted,
                              activeColor: burgundy,
                              onChanged: (value) {
                                setState(() {
                                  tasks[index]['completed'] = value!;
                                });
                              },
                            ),
                            title: Text(
                              tasks[index]['title'],
                              style: TextStyle(
                                color: isCompleted
                                    ? mutedText
                                    : darkText,
                                fontWeight: FontWeight.w500,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert_rounded,
                                color: mutedText,
                              ),
                              color: ivory,
                              onSelected: (value) {
                                if (value == 'edit') {
                                  showTaskDialog(index: index);
                                } else if (value == 'delete') {
                                  deleteTask(index);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_rounded,
                                        color: burgundy,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline_rounded,
                                        color: rosePink,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showTaskDialog();
        },
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Task'),
      ),
    );
  }

  Widget _buildCountCard(String title, int count, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: rosePink,
            size: 27,
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: const TextStyle(
              color: burgundy,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: mutedText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
