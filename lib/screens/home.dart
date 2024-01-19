import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cours_en_ligne/screens/category.dart';
import 'package:cours_en_ligne/screens/cours.dart';
import 'package:cours_en_ligne/screens/profile.dart';
import 'package:cours_en_ligne/models/course.dart';
import 'package:cours_en_ligne/models/category_list.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cours_en_ligne/screens/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryScreen()),
          );
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
            MaterialPageRoute(builder: (context) => ProfileScreen('333@gmail.com')),
          );
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours en Ligne'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher des cours',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/banner/figma.jpeg',
                      width: 480,
                      height: 270,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.7),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Figma UI UX Design Essentials',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/banner/flutter.jpeg',
                      width: 480,
                      height: 270,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.7),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Flutter & Dart - The Complete Guide [2023 Edition]',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/banner/java.jpeg',
                      width: 480,
                      height: 270,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.7),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Java Programming Masterclass updated to Java 17',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 500),
                viewportFraction: 0.8,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Catégories populaires",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryScreen()),
                      );
                    },
                    child: Text(
                      "Voir Plus",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final randomCategory = categories[random.nextInt(categories.length)];
                return CategoryCard(
                  categoryName: randomCategory.titre,
                  image: randomCategory.image,
                );
              },
              childCount: 4,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
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
    );
  }
}


// Sidebar
// import 'package:cours_en_ligne/screens/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cours_en_ligne/screens/category.dart';
// import 'package:cours_en_ligne/models/course.dart';
// import 'package:cours_en_ligne/models/category_list.dart';
// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cours_en_ligne/screens/auth.dart';

// class HomeScreen extends StatelessWidget {
//   Random random = Random();

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cours en Ligne'),
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
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverToBoxAdapter(
//             child: SizedBox(height: 20),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Rechercher des cours',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 20),
//           ),
//           SliverToBoxAdapter(
//             child: CarouselSlider(
//               items: [
//                 Stack(
//                   children: [
//                     Image.asset(
//                       'assets/banner/figma.jpeg',
//                       width: 480,
//                       height: 270,
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: Container(
//                         color: Colors.black.withOpacity(0.7),
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Figma UI UX Design Essentials',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Stack(
//                   children: [
//                     Image.asset(
//                       'assets/banner/flutter.jpeg',
//                       width: 480,
//                       height: 270,
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: Container(
//                         color: Colors.black.withOpacity(0.7),
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Flutter & Dart - The Complete Guide [2023 Edition]',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Stack(
//                   children: [
//                     Image.asset(
//                       'assets/banner/java.jpeg',
//                       width: 480,
//                       height: 270,
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: Container(
//                         color: Colors.black.withOpacity(0.7),
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Java Programming Masterclass updated to Java 17',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//               options: CarouselOptions(
//                 height: 200,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 aspectRatio: 16/9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: Duration(milliseconds: 500),
//                 viewportFraction: 0.8,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 20),
//           ),
//           SliverToBoxAdapter(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 10.0),
//                   child: Text(
//                     "Catégories populaires",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 10.0),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => CategoryScreen()),
//                       );
//                     },
//                     child: Text(
//                       "Voir Plus",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 20),
//           ),
//           SliverGrid(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 1,
//               mainAxisSpacing: 20,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 final randomCategory = categories[random.nextInt(categories.length)];
//                 return CategoryCard(
//                   categoryName: randomCategory.titre,
//                   image: randomCategory.image,
//                 );
//               },
//               childCount: 4,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(height: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }
