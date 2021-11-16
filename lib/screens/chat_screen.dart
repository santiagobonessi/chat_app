import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('Chat list'),
        ),
      ),
    );
  }
}
