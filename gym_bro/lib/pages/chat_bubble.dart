import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.grey[300] : Colors.black,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              message,
              style: TextStyle(color: isUser ? Colors.black : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
