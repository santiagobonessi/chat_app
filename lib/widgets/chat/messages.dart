import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  final userId = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return MessageBubble(
              documents[index]['text'],
              documents[index]['username'],
              documents[index]['userImage'],
              documents[index]['userId'] == userId,
              key: ValueKey(documents[index].id),
            );
          },
          itemCount: documents.length,
        );
      },
    );
  }
}
