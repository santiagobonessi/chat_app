import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String userName, File image, bool isLogin) async {
    UserCredential userCredetial;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredetial = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredetial = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance.ref().child('user_images').child(userCredetial.user.uid + '.jpg');
        await ref.putFile(image).whenComplete(() => null);

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(userCredetial.user.uid).set(
          {
            'username': userName,
            'email': email,
            'imageUrl': imageUrl,
          },
        );
      }
    } catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
