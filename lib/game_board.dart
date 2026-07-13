import 'package:flutter/material.dart';
import 'package:hola_word/Viuw/cuadrados.dart';
import 'package:hola_word/main.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardstate();
}

class _GameBoardstate extends State<GameBoard> {
  late List<List<ChessPiece?>> board;
  //iniciar el Proyecto
  @override
  void initState() {
    super.initState();
    _initializeBoard();
    List<List<ChessPiece?>> newBoard = List.generate(
      8,
      (index) => List.generate(8, (index) => null),
    );

    //colocar los peones

    //colocar las torres

    //colocar los caballos

    //colocar los alfiles

    //colocar la reina

    //colocar el rey
  }

  //inicio de aplicacion
  void _initializeBoard() {}

  ChessPiece myPawn = ChessPiece(
    type: ChessPieceType.pawn,
    isWhite:
        true, //esto define si los peones van a hacer blancos o negros mediante en true o false
    imagePath: 'assets/pieces/w_p.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
