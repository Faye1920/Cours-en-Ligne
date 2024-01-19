// course_detail.dart
import 'package:flutter/material.dart';
import 'package:cours_en_ligne/models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final Function(Course) onAddToCourse;

  CourseDetailScreen({required this.course, required this.onAddToCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Cours'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                course.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                course.titre,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    onAddToCourse(course);
                  },
                  child: Text('Ajouter au cours'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle watch now button click event
                  },
                  child: Text('Regarder maintenant'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
