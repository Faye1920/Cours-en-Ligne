import 'package:flutter/material.dart';
import 'package:cours_en_ligne/screens/profile.dart';
import 'package:cours_en_ligne/screens/home.dart';
import 'package:cours_en_ligne/screens/cours.dart';
import 'package:cours_en_ligne/models/category_list.dart';
import 'package:cours_en_ligne/screens/course_list.dart';
import 'package:cours_en_ligne/models/course.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _currentIndex = 1;

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
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CoursScreen()),
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 5,
          children: List.generate(categories.length, (index) {
            return CategoryCard(
              categoryName: categories[index].titre,
              image: categories[index].image,
            );
          }),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String image;

  CategoryCard({required this.categoryName, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (categoryName == 'Développement mobile') {
                return CourseListScreen(courses: mobileCourses);
              } else if (categoryName == 'Langage de programmation') {
                return CourseListScreen(courses: langageCourses);
              }
              return Container();
              // Add more conditions for other categories if necessary
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 120,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Sidebar
// import 'package:flutter/material.dart';
// import 'package:cours_en_ligne/screens/profile.dart';
// import 'package:cours_en_ligne/screens/home.dart';
// import 'package:cours_en_ligne/models/category_list.dart';
// import 'package:cours_en_ligne/screens/course_list.dart';
// import 'package:cours_en_ligne/models/course.dart';

// class CategoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Catégories'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text('Acceuil'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.category),
//               title: Text('Catégories'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CategoryScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.book),
//               title: Text('Cours'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.account_circle),
//               title: Text('Profil'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfileScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: GridView.count(
//           crossAxisCount: 2,
//           mainAxisSpacing: 20,
//           crossAxisSpacing: 5,
//           children: List.generate(categories.length, (index) {
//             return CategoryCard(
//               categoryName: categories[index].titre,
//               image: categories[index].image,
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String categoryName;
//   final String image;

//   CategoryCard({required this.categoryName, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               if (categoryName == 'Développement mobile') {
//                 return CourseListScreen(courses: mobileCourses);
//               } else if (categoryName == 'Langage de programmation') {
//                 return CourseListScreen(courses: langageCourses);
//               }
//               return Container();
//               // Add more conditions for other categories if necessary
//             },
//           ),
//         );
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 0.5),
//           ),
//           child: Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   image,
//                   height: 120,
//                   width: 180,
//                   fit: BoxFit.cover,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     categoryName,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
