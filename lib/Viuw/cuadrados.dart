import 'package:flutter/material.dart';
import 'package:hola_word/main.dart';

class Cuadrados extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  const Cuadrados({super.key, required this.isWhite, required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isWhite ? foregroundColor : backgroundColor,
      //peon
      child: piece != null
          ? Image.asset(
              piece!.imagePath,
              color: piece!.isWhite ? Colors.white : Colors.black,
            )
          : null,
    );
  }
}

//el fondo
var backgroundColor = Colors.grey[700];
var foregroundColor = Colors.grey[500];
