import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asian College TO-DO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0056b3),
          secondary: Color(0xFFFFD700),
        ),
        primaryColor: Color(0xFF0056b3),
        primaryColorLight: Color(0xFFFFD700),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0056b3),
        ),
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});
  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final List<String> _categories = ['Academic', 'Personal', 'Work'];

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        DateTime? dueDate;
        String? category;

        return AlertDialog(
          title: Text('Add Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Category'),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) => category = value,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    dueDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                  child: Text('Select Due Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && dueDate != null && category != null) {
                  setState(() {
                    _tasks.add({
                      'title': title,
                      'description': description,
                      'dueDate': dueDate,
                      'category': category,
                      'completed': false,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String title = _tasks[index]['title'];
        String description = _tasks[index]['description'];
        DateTime? dueDate = _tasks[index]['dueDate'];
        String? category = _tasks[index]['category'];

        return AlertDialog(
          title: Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: TextEditingController(text: title),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  controller: TextEditingController(text: description),
                  onChanged: (value) => description = value,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Category'),
                  value: category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) => category = value,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    dueDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                  child: Text('Select Due Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && dueDate != null && category != null) {
                  setState(() {
                    _tasks[index]['title'] = title;
                    _tasks[index]['description'] = description;
                    _tasks[index]['dueDate'] = dueDate;
                    _tasks[index]['category'] = category;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _markTaskComplete(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  bool _isApproachingDueDate(DateTime? dueDate) {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference >= 0 && difference <= 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://scontent.fceb1-4.fna.fbcdn.net/v/t39.30808-6/327249607_881047072947258_7877524534634613222_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Yzt_nIv_N2sQ7kNvwGAtPEU&_nc_oc=AdkWgK0moHIASJZawcFdVsw8x0WKFLbCrcXIpE_cDC-mUG89T5QKiadTXMFDnLUvEzo&_nc_zt=23&_nc_ht=scontent.fceb1-4.fna&_nc_gid=lH-clW2Q28JOuldsSRow2w&oh=00_AfKs_aHLYVe9k8niY00Amo0_b9QtbQo5GrbSlsIHehDY0A&oe=682343D3',
              height: 40,
            ),
            SizedBox(width: 20),
            Text(
              'To Do App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final isApproaching = _isApproachingDueDate(task['dueDate']);
          return ListTile(
            title: Text(
              task['title'],
              style: TextStyle(
                color: isApproaching ? Colors.red : Colors.black,
                decoration: task['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task['description'].isNotEmpty)
                  Text('Description: ${task['description']}'),
                if (task['dueDate'] != null)
                  Text('Due Date: ${task['dueDate'].toString().split(' ')[0]}'),
                if (task['category'] != null)
                  Text('Category: ${task['category']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editTask(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTask(index),
                ),
                Checkbox(
                  value: task['completed'],
                  onChanged: (value) => _markTaskComplete(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Color(0xFFFFD700),
        child: Icon(Icons.add),
      ),
    );
  }
}
