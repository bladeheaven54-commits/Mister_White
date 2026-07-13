import 'package:flutter/material.dart';
import 'package:hola_word/main.dart';

class Cuadrados extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  const Cuadrados({super.key, required this.isWhite, required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isWhite ? Colors.grey[200] : Colors.grey[500],
      //peon
      child: piece != null ? Image.asset(piece!.imagePath) : null,
    );
  }
}
