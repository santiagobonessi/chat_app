import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for error
          if (snapshot.hasError) {
            print('Error with Firebase initialize method');
          }

          // Once complete, show app
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Chat App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.pink,
                backgroundColor: Colors.pink,
                accentColor: Colors.deepPurple,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return ChatScreen();
                  }
                  return AuthScreen();
                },
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
