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

  // una lista de piezas blancas que han sido capturas
  List<ChessPiece> whitePiecesTakes = [];

  // una lista de piezas  negras que han sido capturas
  List<ChessPiece> blackPiecesTakes = [];

  // un boleano para indicar si es el turno blanco o turno negro
  bool isWhiteTurn = true;

  // inicial posicion del rey (keep track of this oto make it easier later to see if king is in check)
  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
  bool checkStatus = false;

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

  //uso de selector de piezas

  void pieceSelected(int row, int col) {
    setState(() {
      //no se ha seleccionado ninguna pieza y esta es la primera seleccion
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.isWhite == isWhiteTurn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      }
      //hay una pieza seleccionada, pero el usuario puede seleccionar otra pieza
      else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      //selecciona una pieza si hay una pieza en esta posicion
      //if (board[row][col] != null) {
      //  selectedPiece = board[row][col];
      //  selectedRow = row;
      //  selectedCol = col;
      //  }
      //una pieza esta seleccionada y el usuario la toca en otra casilla que es un movimiento valido
      else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }

      //despues de seleccionar una pieza calcula sus movimientos validos
      validMoves = calculateRealValidMoves(
        selectedRow,
        selectedCol,
        selectedPiece,
        true,
      );
    });
  }
  //CALCULA MOVIMIENTOS VALIDOS BRUTOS

  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    //diferencias segun el color
    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        //los peones pueden caminar 1 paso
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }
        //los peones puden caminar 2 pasos al inicio
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }
        //los peones pueden matar en diagonal 1 paso
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
        //movimiento horizontal
        var directions = [
          [-1, 0], //up
          [1, 0], //down
          [0, -1], //left
          [0, 1], //right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); //muerte
              }
              break; //bucle bloqueado
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        //movimiento en L para el caballo
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1  left 2
          [-1, 2], //up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], //down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); //captura
            }
            continue; //bloqueado
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
      case ChessPieceType.bishop:
        //alfil dirrecion en diagonal
        var directions = [
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); //captura
              }
              break; //bloqueado
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        //la reyna se mueve entodas direciones, izquierda, derecha, arriba, abajo, y diagonal
        var directions = [
          [-1, 0], //up
          [1, 0], //down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], //down left
          [1, 1], // down right
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // capture
              }
              break; // bloqueado
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        // el rey se mueve para todos lados pero a un paso
        var directions = [
          [-1, 0], //up
          [1, 0], //down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], //down left
          [1, 1], // down right
        ];
        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // capturado
            }
            continue; //bloqueado
          }
          candidateMoves.add([newRow, newCol]);
        }

        break;
    }
    return candidateMoves;
  }

  // CALCULA MOVIENTO VALIDO
  List<List<int>> calculateRealValidMoves(
    int row,
    int col,
    ChessPiece? piece,
    bool checkSimulation,
  ) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);

    // alter generating all los movimientos validos, vamos a filtrar cualquiera que resulte en un jaque del Rey
    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];

        //simula un futuro movimiento si es seguro
        if (simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

  //MOMENTO DE LA CAPACIDAD DE MOVER PIEZAS
  void movePiece(int newRow, int newCol) {
    // si el nuevo lugar tiene una pieza enemigo
    if (board[newRow][newCol] != null) {
      //agregar la captura piece  y se apropiela list
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTakes.add(capturedPiece);
      } else {
        blackPiecesTakes.add(capturedPiece);
      }
    }

    //jaque si la pieza verifica q la que se mueve es un rey
    if (selectedPiece!.type == ChessPieceType.king) {
      //actualizar la propiedades del rey
      if (selectedPiece!.isWhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    //movemos la pieza y se borra en el lugar anterior
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // si algun Rey esta bajo atanque
    if (isKingInCheck(!isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }

    //borrar la seleccion
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
    // check if its check mate
    if (isCheckMate(!isWhiteTurn)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("JAQUE MATE MAMAGUEVO"),
          actions: [
            //jugar de nuevo
            TextButton(
              onPressed: resetGame,
              child: const Text("Jugar de nuevo"),
            ),
          ],
        ),
      );
    }

    //change turns
    isWhiteTurn = !isWhiteTurn;
  }

  // IS KING IN CHECK?
  bool isKingInCheck(bool isWhiteKing) {
    //get the position of the king
    List<int> kingPosition = isWhiteKing
        ? whiteKingPosition
        : blackKingPosition;

    // check if any enemy piece can attack the king
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // skip empty squares and pieces of the same color as the king
        if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing) {
          continue;
        }
        List<List<int>> pieceValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          false,
        );

        //check is the king's position is in this  piece's valid moves
        if (pieceValidMoves.any(
          (move) => move[0] == kingPosition[0] && move[1] == kingPosition[1],
        )) {
          return true;
        }
      }
    }
    return false;
  }

  // SIMULA UN FUTURO MOVIMIENTO PARA VER SI ES SEGURO(NO PONE A NUESTRO PROPIO REY BAJO TAQUE)
  bool simulatedMoveIsSafe(
    ChessPiece piece,
    int startRow,
    int startCol,
    int endRow,
    int endCol,
  ) {
    //save the current board state

    ChessPiece? originalDestinationPiece = board[endRow][endCol];

    //if the ppiece is the king, save its curret position and update to the new one
    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition = piece.isWhite
          ? whiteKingPosition
          : blackKingPosition;

      //update the king position
      if (piece.isWhite) {
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }

    //Simulate the move
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    //check if our king is under attack
    bool kingInCheck = isKingInCheck(piece.isWhite);

    //restore board to original state
    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    //if the piece was the king, restore it original position
    if (piece.type == ChessPieceType.king) {
      if (piece.isWhite) {
        whiteKingPosition = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }
    // if king is in check = true, means its not a safe move. safe move = false
    return !kingInCheck;
  }

  //IS IT CHECK MATE

  bool isCheckMate(bool isWhiteKing) {
    // if the king is not in check, then its not checkmate
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }
    // if there is at least one legl move for any of the players pieces, then its not checkmate
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        //skip empty square nad pieces of the other color
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves = calculateRealValidMoves(
          i,
          j,
          board[i][j],
          true,
        );

        //if this piece has any valid moves, then its not checkmate
        if (pieceValidMoves.isNotEmpty) {
          return false;
        }
      }
    }
    // if none of the above conditions are met, then there are no legal moves left to make

    //its check mate!
    return true;
  }

  //RESET TO NEW GAME
  void resetGame() {
    Navigator.pop(context);
    _initializeBoard();
    checkStatus = false;
    whitePiecesTakes.clear();
    blackPiecesTakes.clear();
    setState(() {
      whiteKingPosition = [7, 4];
      blackKingPosition = [0, 4];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          //WHITE PIECES TAKEN
          Expanded(
            child: GridView.builder(
              itemCount: whitePiecesTakes.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) => DeadPiece(
                imagePath: whitePiecesTakes[index].imagePath,
                isWhite: true,
              ),
            ),
          ),

          // ESTADO EL JUEGO
          Text(checkStatus ? "JAQUE!" : ""),
          // CHEES BOARD
          Expanded(
            // flex: 3 significa la logitud vertical en telefono
            flex: 3,
            child: GridView.builder(
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

                //verifica si los mocimientos son validos
                bool isValidMove = false;
                for (var posicion in validMoves) {
                  //comparacion entre colummnas

                  if (posicion[0] == row && posicion[1] == col) {
                    isValidMove = true;
                  }
                }
                // ESTO ES MUY IMPORTANTE A LA HORA DE CORRER LA APP
                return Cuadrados(
                  isWhite: isWhite,
                  piece: board[row][col],
                  isSelected: isSelected,
                  isValidMove: isValidMove,
                  onTab: () => pieceSelected(row, col),
                );
              },
            ),
          ),

          // BLACK PIECES TAKES
          Expanded(
            child: GridView.builder(
              itemCount: blackPiecesTakes.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) => DeadPiece(
                imagePath: blackPiecesTakes[index].imagePath,
                isWhite: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//movimiento

bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}

//clase DE MUERTE DE PIEZAS
class DeadPiece extends StatelessWidget {
  final String imagePath;
  final bool isWhite;

  const DeadPiece({
    // un comentario porque esta mondaaa no funciona
    super.key,
    required this.imagePath,
    required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      color: isWhite ? Colors.grey[400] : Colors.grey[900],
    );
  }
}
