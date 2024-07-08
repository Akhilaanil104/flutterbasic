import 'package:hive/hive.dart';
import 'student.dart';

class StudentService {
  final Box<Student> studentBox;

  StudentService(this.studentBox);

  void addStudent(Student student) {
    studentBox.put(student.id, student);
  }

  void updateStudent(Student student) {
    student.save();
  }

  void deleteStudent(String id) {
    studentBox.delete(id);
  }

  List<Student> getStudents() {
    return studentBox.values.toList();
  }
}
