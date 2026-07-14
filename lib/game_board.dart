import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

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
  //para selleccionar
  ChessPiece? selectedPiece;
  //registro de fila y columna
  //-1 por defecto no ha seleccionado nada
  int selectedRow = -1;

  //-1 por defecto no ha seleccionado nada
  int selectedCol = -1;

  // movimientos validos de las fichas
  //y se va a representar como una lista con 2 Elementos, filas y columnas
  List<List<int>> validMoves = [];

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
    newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/pieces/w_r.png',
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'assets/pieces/w_r.png',
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/pieces/w_r.png',
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'assets/pieces/w_r.png',
    );
    //colocar los caballos
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/pieces/b_n.png',
    );
    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'assets/pieces/b_n.png',
    );

    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/pieces/w_n.png',
    );
    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'assets/pieces/w_n.png',
    );
    //colocar los alfiles
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/pieces/b_b.png',
    );
    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'assets/pieces/b_b.png',
    );
    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/pieces/w_b.png',
    );
    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'assets/pieces/w_b.png',
    );
    //colocar la reina
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: 'assets/pieces/b_k.png',
    );
    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: 'assets/pieces/w_k.png',
    );
    //colocar el rey
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: 'assets/pieces/b_q.png',
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: 'assets/pieces/w_q.png',
    );

    board = newBoard;
  }

  //inicio de aplicacion
  void _initializeBoard() {}

  //uso de selector por usuario

  void pieceSelected(int row, int col) {
    setState(() {
      //selecciona una pieza si hay una pieza en esta posicion
      if (board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      //despues de seleccionar una pieza calcula sus movimientos validos
      validMoves = calculateRawValidMoves(
        selectedRow,
        selectedCol,
        selectedPiece,
      );
    });
  }
  //CALCULA MOVIMIENTOS VALIDOS BRUTOS

  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    //diferencias segun el color
    int direction = piece!.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        //los peones pueden caminar 1 paso

        //los peones puden caminar 2 pasos al inicio

        //los peones pueden matar en diagonal 1 paso

        break;
      case ChessPieceType.rook:
        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.queen:
        break;
      case ChessPieceType.king:
        break;

      default:
    }
  }

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

          bool isSelected = selectedRow == row && selectedCol == col;
          return Cuadrados(
            isWhite: isWhite,
            piece: board[row][col],
            isSelected: isSelected,
            onTab: () => pieceSelected(row, col),
          );
        },
      ),
    );
  }
}
