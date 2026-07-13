import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Expanded(
              child: Container(
                height: 200,
                decoration: const BoxDecoration(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
