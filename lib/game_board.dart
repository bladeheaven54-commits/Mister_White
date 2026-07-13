import 'package:flutter/material.dart';
import 'package:hola_word/Viuw/cuadrados.dart';
import 'package:hola_word/main.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardstate();
}

class _GameBoardstate extends State<GameBoard> {
  ChessPiece myPawn = ChessPiece(
    type: ChessPieceType.pawn,
    isWhite:
        true, //esto define si los peones van a hacer blancos o negros mediante en true o false
    imagePath: 'assets/pieces/w_p.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 8 * 8,
        //Las physics conjelan la tabla
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) {
          int x = index ~/ 8;
          int y = index % 8;

          bool isWhite = (x + y) % 2 == 0;

          return Cuadrados(isWhite: isWhite, piece: myPawn);
        },
      ),
    );
  }
}
