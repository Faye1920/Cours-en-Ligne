import 'package:flutter/material.dart';
import 'package:cours_en_ligne/screens/home.dart';
import 'package:cours_en_ligne/screens/category.dart';
import 'package:cours_en_ligne/screens/cours.dart';
import 'package:cours_en_ligne/screens/user_creation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  ProfileScreen(this.email);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, String> profileInfo = {
    'Prénom': '',
    'Nom': '',
    'Numéro de dossier': '',
    'Nom de l’institution': '',
    'Adresse e-mail': '',
  };

  File? _image;
  int _currentIndex = 0;
  String? documentId;

  @override
  void initState() {
    super.initState();
    _getUserInfo(widget.email);

    // Générer un "Numéro de dossier" aléatoire
    String? email = profileInfo['Adresse e-mail'];
    if (email != null) {
      int randomNum = generateRandomNum(email);
      profileInfo['Numéro de dossier'] = randomNum.toString();
    }
  }

  Future<void> _getUserInfo(String email) async {
  try {
    QuerySnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance
        .collection('users')
        .where('Adresse e-mail', isEqualTo: email)
        .get();

    if (userInfo.docs.isNotEmpty) {
      var user = userInfo.docs.first;
      documentId = user.id;

      Map<String, String> newProfileInfo = {
        'Prénom': user['prenom'],
        'Nom': user['nom'],
        'Numéro de dossier': user['numéro de dossier'].toString(),
        'Nom de l’institution': user['nom de l\'institution'],
        'Adresse e-mail': user['Adresse e-mail'],
      };

      setState(() {
        profileInfo = newProfileInfo;
      });
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
}


  int generateRandomNum(String email) {
    int hash = 0;
    for (int i = 0; i < email.length; i++) {
      hash = 31 * hash + email.codeUnitAt(i);
    }
    return hash.abs() % 900000 + 100000;
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _showImageOptionsDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisir une image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Prendre une photo'),
                  onTap: () {
                    _getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('Choisir une photo existante'),
                  onTap: () {
                    _getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(String key, String value) {
    String newValue = value;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier $key'),
          content: TextField(
            onChanged: (newText) {
              newValue = newText;
            },
            controller: TextEditingController(text: value),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sauvegarder'),
              onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(documentId)
                    .update({key.toLowerCase(): newValue});
              } catch (e) {
                print('Error fetching user data:：$e');
              }

              setState(() {
                profileInfo[key] = newValue;
              });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoryScreen()),
      );
      break;
    case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoursScreen()),
      );
      break;
    case 3:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen('asdf@gmail.com')),
      );
      break;
  }

  // 将 _currentIndex 更新放在 setState 的回调中
  setState(() {
    _currentIndex = index;
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          GestureDetector(
            onTap: _showImageOptionsDialog,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.person) : null,
              ),
            ),
          ),
          SizedBox(height: 30),
          for (var entry in profileInfo.entries)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              child: ListTile(
                title: Text(
                  entry.key,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(entry.value),
                trailing: entry.key != 'Adresse e-mail' && entry.key != 'Numéro de dossier'
                  ? Icon(Icons.arrow_forward_ios)
                  : null,
                onTap: () {
                  if (entry.key != 'Adresse e-mail' && entry.key != 'Numéro de dossier') {
                    _showEditDialog(entry.key, entry.value);
                  }
                },
              ),
            ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => EcranCreationUtilisateur()),
                (route) => false,
              );
            },
            child: Text('Déconnexion'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 3,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CoursScreen()),
                );
                break;
              case 3:
                break;
            }
          });
        },
      ),
    );
  }
}


// Sidebar
// import 'package:flutter/material.dart';
// import 'package:cours_en_ligne/screens/home.dart';
// import 'package:cours_en_ligne/screens/category.dart';
// import 'package:cours_en_ligne/screens/user_creation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   Map<String, String> profileInfo = {
//     'Prénom': '',
//     'Nom': '',
//     'Numéro de dossier': '',
//     'Nom de l’institution': '',
//     'Adresse e-mail': '111@gmail.com',
//   };

//   File? _image;

//   @override
//   void initState() {
//     super.initState();

//     // Générer un "Numéro de dossier" aléatoire
//     String? email = profileInfo['Adresse e-mail'];
//     if (email != null) {
//       int randomNum = generateRandomNum(email);
//       profileInfo['Numéro de dossier'] = randomNum.toString();
//     }
//   }

//   int generateRandomNum(String email) {
//     int hash = 0;
//     for (int i = 0; i < email.length; i++) {
//       hash = 31 * hash + email.codeUnitAt(i);
//     }
//     return hash.abs() % 900000 + 100000;
//   }

//   Future<void> _getImageFromCamera() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   Future<void> _getImageFromGallery() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   Future<void> _showImageOptionsDialog() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choisir une image'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text('Prendre une photo'),
//                   onTap: () {
//                     _getImageFromCamera();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                 ),
//                 GestureDetector(
//                   child: Text('Choisir une photo existante'),
//                   onTap: () {
//                     _getImageFromGallery();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showEditDialog(String key, String value) {
//     String newValue = value;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Modifier $key'),
//           content: TextField(
//             onChanged: (newText) {
//               newValue = newText;
//             },
//             controller: TextEditingController(text: value),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Annuler'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Sauvegarder'),
//               onPressed: () {
//                 setState(() {
//                   profileInfo[key] = newValue;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profil'),
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
//       body: ListView(
//         padding: EdgeInsets.all(20.0),
//         children: [
//           GestureDetector(
//             onTap: _showImageOptionsDialog,
//             child: Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: _image != null ? FileImage(_image!) : null,
//                 child: _image == null ? Icon(Icons.person) : null,
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           for (var entry in profileInfo.entries)
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey, width: 1.0),
//                 ),
//               ),
//               child: ListTile(
//                 title: Text(
//                   entry.key,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(entry.value),
//                 trailing: entry.key != 'Numéro de dossier'
//                     ? Icon(Icons.arrow_forward_ios)
//                     : null,
//                 onTap: () {
//                   if (entry.key != 'Numéro de dossier') {
//                     _showEditDialog(entry.key, entry.value);
//                   }
//                 },
//               ),
//             ),
//           SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => EcranCreationUtilisateur()),
//               (route) => false,
//     );
//             },
//             child: Text('Déconnexion'),
//           ),
//         ],
//       ),
//     );
//   }
// }
