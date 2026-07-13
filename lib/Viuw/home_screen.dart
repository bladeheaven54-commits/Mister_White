import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
