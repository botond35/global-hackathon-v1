// bro_page.dart
import 'package:flutter/material.dart';
import 'package:gym_bro/data/models.dart';
import 'package:gym_bro/data/data_service.dart';
import 'package:gym_bro/data/message_handler.dart';
import 'package:gym_bro/pages/chat_bubble.dart';
import 'package:gym_bro/pages/message_input.dart';

class BroPage extends StatefulWidget {
  const BroPage({super.key});

  @override
  State<BroPage> createState() => _BroPageState();
}

class _BroPageState extends State<BroPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late MessageHandler _messageHandler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final gymData = await DataService.loadGymData();
      _messageHandler = MessageHandler(gymData: gymData);

      setState(() {
        _isLoading = false;
        _messages.add(
          ChatMessage(
            text:
                "Hey bro! I'm your gym assistant. Ask me about workouts or nutrition!",
            isUser: false,
          ),
        );
      });
    } catch (e) {
      // Use debugPrint for production
      debugPrint("Error initializing app: $e");
      setState(() {
        _isLoading = false;
        _messages.add(
          ChatMessage(
            text: "Sorry bro, having trouble loading my knowledge base!",
            isUser: false,
          ),
        );
      });
    }
  }

  void _sendMessage(String text) {
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    _getBotResponse(text);
    _textController.clear();
  }

  void _getBotResponse(String userMessage) {
    Future.delayed(const Duration(milliseconds: 500), () {
      final response = _messageHandler.handleMessage(userMessage);
      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gym Bro Assistant")),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return ChatBubble(
                        message: message.text,
                        isUser: message.isUser,
                      );
                    },
                  ),
          ),
          MessageInput(
            controller: _textController,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}
