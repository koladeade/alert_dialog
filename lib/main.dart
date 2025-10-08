import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertDialog Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List of tasks to display
  List<String> tasks = ['Watch Edpuzzle', 'Finish homework'];

  // Function to delete a task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Function to show the delete confirmation dialog
  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      // PROPERTY 1: barrierDismissible
      // If false, user MUST tap a button to close the dialog
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // PROPERTY 2: title
          // The heading widget at the top of the dialog
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text('Confirm Delete'),
            ],
          ),

          // PROPERTY 3: content
          // The main message body of the dialog
          content: Text(
            'Are you sure you want to delete "${tasks[index]}"?\n\nThis action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),

          // Actions: buttons at the bottom of the dialog
          actions: [
            // Cancel button
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            // Delete button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text('Delete', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _deleteTask(index); // Delete the task
              },
            ),
          ],

          // Additional styling
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Task List'),
        centerTitle: true,
        elevation: 2,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'All tasks completed!',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(tasks[index], style: TextStyle(fontSize: 16)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete task',
                      onPressed: () => _showDeleteDialog(context, index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
