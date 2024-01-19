import 'package:flutter/material.dart';
import 'package:cours_en_ligne/screens/course_detail.dart';
import 'package:cours_en_ligne/models/course.dart';

class CourseListScreen extends StatelessWidget {
  final List<Course> courses;

  CourseListScreen({required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(
                    course: course,
                    onAddToCourse: (selectedCourse) {
                    },
                  ),
                ),
              );
            },
            child: Card(
              child: Row(
                children: [
                  Image.asset(
                    course.image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      course.titre,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
