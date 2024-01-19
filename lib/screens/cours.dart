import 'package:flutter/material.dart';
import 'package:cours_en_ligne/screens/profile.dart';
import 'package:cours_en_ligne/screens/home.dart';
import 'package:cours_en_ligne/screens/category.dart';
import 'package:cours_en_ligne/screens/course_list.dart';
import 'package:cours_en_ligne/models/course.dart';

class CoursScreen extends StatefulWidget {
  @override
  _CoursScreenState createState() => _CoursScreenState();
}

class _CoursScreenState extends State<CoursScreen> {
  int _currentIndex = 2;
  List<Course> selectedCourses = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryScreen()),
          );
          break;
        case 2:
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen('111@gmail.com')),
          );
          break;
      }
    });
  }

  void addToCourse(Course course) {
    setState(() {
      selectedCourses.add(course);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: selectedCourses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              selectedCourses[index].image,
              height: 50,
              width: 50,
            ),
            title: Text(selectedCourses[index].titre),
          );
        },
      ),
    );
  }
}
