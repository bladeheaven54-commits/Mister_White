import 'package:flutter/material.dart';

class Cuadrados extends StatelessWidget {
  final bool isWhite;
  const Cuadrados({super.key, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Container(color: isWhite ? Colors.grey[200] : Colors.grey[500]);
  }
}
