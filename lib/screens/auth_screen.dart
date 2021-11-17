import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String password, String username, bool isLogin) async {
    UserCredential userCredetial;
    try {
      if (isLogin) {
        userCredetial = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredetial = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
      print(userCredetial.user);
    } catch (error) {
      var message = 'An error occurred, please check your cerdentials!';
      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
