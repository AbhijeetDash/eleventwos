import 'dart:math';

import '../models/models.dart';
import '../utils/_util_locator.dart';
import 'services.dart';

// TODO : Refactor the service.
abstract class BoardService {
  /// Generates a empty board with two random values.
  /// Call this when starting a new game.
  Board generateInitialBoard(int size);

  /// Gets the list of indexes with empty positions.
  List<Block> getAllEmptyPositions(Board board);

  /// Assigns initial value to empty tiles in the board.
  void addRandomBlocks();

  /// Check if a given position is empty or not.
  /// returns true if empty and false if not.
  bool checkPositionState(Block block);

  // Check if can move left
  bool canMoveLeft();

  // Check if can move right
  bool canMoveRight();

  // Check if can move up
  bool canMoveUp();

  // Check if can move down
  bool canMoveDown();

  // Merge the blocks in the right direction.
  void actionRightMerge(int row, int column);

  // Merge the blocks in the left direction.
  void actionLeftMerge(int row, int column);

  // Merge the blocks in the up direction.
  void actionUpMerge(int row, int column);

  // Merge the blocks in the down direction.
  void actionDownMerge(int row, int column);

  // Move the blocks in the right direction.
  void actionRightMove(int row, int column);

  // Move the blocks in the left direction.
  void actionLeftMove(int row, int column);

  // Move the blocks in the up direction.
  void actionUpMove(int row, int column);

  // Move the blocks in the down direction.
  void actionDownMove(int row, int column);

  // reset the canMerge property of all the blocks.
  void resetCanMerge();
}

class BoardServiceImpl extends BoardService {
  late final Board board;
  late final BlockService blockService;

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
    board = Board(size: size, score: 0, blocks: blocks);

    // Reset can merge
    resetCanMerge();

    // Adding two random blocks to the board.
    addRandomBlocks();
    addRandomBlocks();

    // Getting the BlockService from the locator.
    blockService = locator.get<BlockService>();
    return board;
  }

  @override
  List<Block> getAllEmptyPositions(Board board) {
    List<Block> emptyBlocks = [];

    // this goes through the rows
    for (int row = 0; row < board.size; row++) {
      // this goes through each col in the above row
      for (int col = 0; col < board.size; col++) {
        if (checkPositionState(board.blocks[row][col])) {
          emptyBlocks.add(board.blocks[row][col]);
        }
      }
    }

    return emptyBlocks;
  }

  @override
  void addRandomBlocks() {
    // Getting all the empty positions.
    List<Block> emptyBlocks = getAllEmptyPositions(board);

    // If there are no empty positions, then return.
    if (emptyBlocks.isEmpty) {
      return;
    }

    // Generate a random number between 0 and the length of the empty blocks.
    // This will be the index of the empty block to be filled.
    int index = Random().nextInt(max(1, emptyBlocks.length));

    // Getting a random empty position.
    Block randomBlock = emptyBlocks[index];

    // generate 2 or 4 randomly with a probability of 80% and 20% respectively.
    int randomValue = Random().nextDouble() < 0.8 ? 2 : 4;

    // Updating the value of the random block.
    Block newRandomBlock =
        randomBlock.copyWith(value: randomValue, canMerge: true);

    // Updating the board.
    try {
      board.blocks[randomBlock.yaxis][randomBlock.xaxis] = newRandomBlock;
    } catch (e) {
      throw Exception("Board not initialised");
    }
  }

  @override
  bool checkPositionState(Block block) {
    return block.isEmpty();
  }

  @override
  void actionDownMerge(int row, int column) {
    while (row < board.size - 1) {
      blockService.mergeBlocks(
        board.blocks[row][column],
        board.blocks[row + 1][column],
      );
      row++;
    }
  }

  @override
  void actionLeftMerge(int row, int column) {
    while (column > 0) {
      blockService.mergeBlocks(
        board.blocks[row][column],
        board.blocks[row][column - 1],
      );
      column--;
    }
  }

  @override
  void actionRightMerge(int row, int column) {
    while (column < board.size - 1) {
      blockService.mergeBlocks(
        board.blocks[row][column],
        board.blocks[row][column + 1],
      );
      column++;
    }
  }

  @override
  void actionUpMerge(int row, int column) {
    while (row > 0) {
      blockService.mergeBlocks(
        board.blocks[row][column],
        board.blocks[row - 1][column],
      );
      row--;
    }
  }

  @override
  bool canMoveLeft() {
    for (int row = 0; row < board.size; ++row) {
      for (int col = 1; col < board.size; ++col) {
        if (blockService.canMergeBlocks(
            board.blocks[row][col], board.blocks[row][col - 1])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  bool canMoveRight() {
    for (int row = 0; row < board.size; ++row) {
      for (int col = board.size - 2; col >= 0; --col) {
        if (blockService.canMergeBlocks(
            board.blocks[row][col], board.blocks[row][col + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  bool canMoveUp() {
    for (int row = 1; row < board.size; ++row) {
      for (int col = 0; col < board.size; ++col) {
        if (blockService.canMergeBlocks(
            board.blocks[row][col], board.blocks[row - 1][col])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  bool canMoveDown() {
    for (int row = board.size - 2; row >= 0; --row) {
      for (int col = 0; col < board.size; ++col) {
        if (blockService.canMergeBlocks(
            board.blocks[row][col], board.blocks[row + 1][col])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  void actionLeftMove(int row, int column) {
    if (!canMoveLeft()) {
      return;
    }

    for (int row = 0; row < board.size; ++row) {
      for (int col = 0; col < board.size; ++col) {
        actionLeftMerge(row, col);
      }
    }

    // Add rantom blocks after the move.
    addRandomBlocks();

    // Reset the canMerge property of all the blocks.
    resetCanMerge();
  }

  @override
  void actionRightMove(int row, int column) {
    if (!canMoveRight()) {
      return;
    }

    for (int row = 0; row < board.size; ++row) {
      for (int col = board.size - 2; col >= 0; --col) {
        actionRightMerge(row, col);
      }
    }

    // Add rantom blocks after the move.
    addRandomBlocks();

    // Reset the canMerge property of all the blocks.
    resetCanMerge();
  }

  @override
  void actionUpMove(int row, int column) {
    if (!canMoveUp()) {
      return;
    }

    for (int row = 0; row < board.size; ++row) {
      for (int col = 0; col < board.size; ++col) {
        actionUpMerge(row, col);
      }
    }

    // Add rantom blocks after the move.
    addRandomBlocks();

    // Reset the canMerge property of all the blocks.
    resetCanMerge();
  }

  @override
  void actionDownMove(int row, int column) {
    if (!canMoveDown()) {
      return;
    }

    for (int row = board.size - 2; row >= 0; --row) {
      for (int col = 0; col < board.size; ++col) {
        actionDownMerge(row, col);
      }
    }

    // Add rantom blocks after the move.
    addRandomBlocks();

    // Reset the canMerge property of all the blocks.
    resetCanMerge();
  }

  @override
  void resetCanMerge() {
    for (int row = 0; row < board.size; ++row) {
      for (int col = 0; col < board.size; ++col) {
        board.blocks[row][col] =
            board.blocks[row][col].copyWith(canMerge: false);
      }
    }
  }
}
