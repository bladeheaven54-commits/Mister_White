import 'package:flutter/material.dart';
import 'package:hola_word/main.dart';

class Cuadrados extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final void Function()? onTab;
  const Cuadrados({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    //color de la seleccion
    if (isSelected) {
      squareColor = Colors.green;
    } else {
      squareColor = isWhite ? foregroundColor : backgroundColor;
    }
    return GestureDetector(
      onTap: onTab,
      child: Container(
        color: squareColor,
        //peon
        child: piece != null
            ? Image.asset(
                piece!.imagePath,
                color: piece!.isWhite ? Colors.white : Colors.black,
              )
            : null,
      ),
    );
  }
}

//el fondo
var backgroundColor = Colors.grey[700];
var foregroundColor = Colors.grey[500];
