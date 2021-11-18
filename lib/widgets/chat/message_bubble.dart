import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMine;
  final String userName;
  final Key key;

  MessageBubble(this.message, this.userName, this.isMine, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMine ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isMine ? Radius.circular(12) : Radius.circular(0),
                bottomRight: !isMine ? Radius.circular(12) : Radius.circular(0)),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: !isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMine ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMine ? Colors.black : Theme.of(context).accentTextTheme.headline1.color,
                ),
                textAlign: isMine ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
