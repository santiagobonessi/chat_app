import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
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
            return Text(
              documents[index]['text'],
            );
          },
          itemCount: documents.length,
        );
      },
    );
  }
}
