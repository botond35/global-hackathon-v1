import 'package:flutter/material.dart';
import 'package:gym_bro/widgets/widget_tree.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "/Users/botond/Documents/global-hackathon-v1/gym_bro/assets/img/5d05170e29ff9b8b9dd6d284e3a8809d.jpg",
            fit: BoxFit.cover,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WidgetTree()),
                );
              },
              child: Text(
                "Let's start workout with GymBro",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
