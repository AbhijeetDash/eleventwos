import '../models/models.dart';

abstract class GameState {}

class GameStateInitial extends GameState {}

// We need this cause same state can't be emmited twice.
class GameStateLoading extends GameState {}

class GameStateOver extends GameState {}

class GameStatePlaying extends GameState {
  final List<Block> blocks;
  final int score;

  GameStatePlaying({
    required this.blocks,
    required this.score,
  });
}
