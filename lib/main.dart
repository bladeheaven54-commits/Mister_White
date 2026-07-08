import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'BebasNeue'),
      home: const Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage('assets/images/fondo1.jpg'),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 200,
              child: Text(
                'Hola Mundo!',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  letterSpacing: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}//una pequeña prueba
//.