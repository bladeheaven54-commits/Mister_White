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
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'assets/pieces/w_p.png',
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'assets/pieces/w_p.png',
      );
    }
    //colocar las torres

    //colocar los caballos

    //colocar los alfiles

    //colocar la reina

    //colocar el rey
    board = newBoard;
  }

  //inicio de aplicacion
  void _initializeBoard() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: 8 * 8,
        physics:
            const NeverScrollableScrollPhysics(), //Las physics conjelan la tabla
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 8;
          int col = index % 8;
          //
          int x = index ~/ 8;
          int y = index % 8;

          bool isWhite = (x + y) % 2 == 0;

          return Cuadrados(isWhite: isWhite, piece: board[row][col]);
        },
      ),
    );
  }
}
