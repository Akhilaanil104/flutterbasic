import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'student.dart';
import 'student_service.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  late StudentService _studentService;
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    studentBox = await Hive.openBox<Student>('students');
    _studentService = StudentService(studentBox);
    setState(() {}); // Trigger a rebuild after the box is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final id = DateTime.now().toString();
              final name = _nameController.text;
              final age = int.parse(_ageController.text);
              final student = Student(id: id, name: name, age: age);
              _studentService.addStudent(student);
              setState(() {});
            },
            child: Text('Add Student'),
          ),
          Expanded(
            child: studentBox == null
                ? Center(child: CircularProgressIndicator())
                : ValueListenableBuilder(
                    valueListenable: studentBox.listenable(),
                    builder: (context, Box<Student> box, _) {
                      if (box.values.isEmpty) {
                        return Center(child: Text('No students added.'));
                      }
                      return ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          final student = box.getAt(index)!;
                          return ListTile(
                            title: Text(student.name),
                            subtitle: Text('Age: ${student.age}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _nameController.text = student.name;
                                    _ageController.text = student.age.toString();
                                    // Implement update logic here
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _studentService.deleteStudent(student.id);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
