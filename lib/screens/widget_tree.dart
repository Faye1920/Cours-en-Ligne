import 'package:cours_en_ligne/screens/auth.dart';
import 'package:cours_en_ligne/screens/home.dart';
import 'package:cours_en_ligne/screens/user_creation.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return EcranCreationUtilisateur();
        }
      },
    );
  }
}
