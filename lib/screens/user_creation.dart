import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cours_en_ligne/screens/auth.dart';
import 'package:cours_en_ligne/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';


class EcranCreationUtilisateur extends StatefulWidget {
  @override
  _EcranCreationUtilisateurState createState() =>
      _EcranCreationUtilisateurState();
}

class _EcranCreationUtilisateurState extends State<EcranCreationUtilisateur> {
  String? errorMesage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _accepteConditions = false;
  String? _emailError;
  String? _passwordError;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      User user = userCredential.user!;

      // 生成随机的 numero de dossier
      Random random = new Random();
      int numeroDossier = random.nextInt(999999); // 生成0到999999之间的随机数

      // 保存用户数据到Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'Adresse e-mail': user.email,
        'Nom': "",
        'Nom de l\'institution': "",
        'Numéro de dossier': numeroDossier,
        'Prénom': "",
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMesage = e.message;
      });
    }
  }


  Widget _title() {
    return Center(
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  
  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMesage == '' ? '' : '$errorMesage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Se Connecter' : 'S\'inscrire'),
    );
  }

  Widget _loginOrRegisterButton() {
  return TextButton(
    onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    },
    child: Text(isLogin ? 'Pas de compte? Créez-en un' : 'Vous avez déjà un compte? Se connecter'),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
