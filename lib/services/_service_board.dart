import '../models/models.dart';

abstract class BoardService {
  /// Generates a empty board with two random values.
  /// Call this when starting a new game.
  Board generateInitialBoard(int size);

  /// Gets the list of indexes with empty positions.
  List<Block> getAllEmptyPositions(Board board);

  /// Check if a given position is empty or not.
  /// returns true if empty and false if not.
  bool checkPositionState(Block block);
}

class BoardServiceImpl extends BoardService {
  @override
  Board generateInitialBoard(int size) {
    // Generating the initial List of tiles.
    List<List<Block>> blocks = List.generate(
      size,
      (index) => List.generate(
        size,
        (crossIndex) => Block(
          xaxis: crossIndex,
          yaxis: index,
          value: 0,
          canMerge: false,
        ),
      ),
    );

    // Creating the initial State of the Game -- Without Default Values.
    Board gameBoard = Board(size: size, score: 0, blocks: blocks);
    return gameBoard;
  }

  @override
  List<Block> getAllEmptyPositions(Board board) {
    List<Block> emptyPairs = [];

    // this goes through the rows
    for (int row = 0; row < board.size; row++) {
      // this goes through each col in the above row
      for (int col = 0; col < board.size; col++) {
        if (checkPositionState(board.blocks[row][col])) {
          emptyPairs.add(board.blocks[row][col]);
        }
      }
    }

    return emptyPairs;
  }

  @override
  bool checkPositionState(Block block) {
    return block.isEmpty();
  }
}
