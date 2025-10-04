import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSendMessage;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Ask about workouts or nutrition...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: onSendMessage,
            ),
          ),
          const SizedBox(width: 8.0),
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => onSendMessage(controller.text),
            ),
          ),
        ],
      ),
    );
  }
}
