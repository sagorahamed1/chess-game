
import 'package:square_bishop/square_bishop.dart';

abstract class GameState {}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final SquaresState boardState;
  final bool aiThinking;
  final bool flipBoard;
  final List<String> moveHistory;

  GameInProgress({
    required this.boardState,
    this.aiThinking = false,
    this.flipBoard = false,
    required this.moveHistory,
  });

  GameInProgress copyWith({
    SquaresState? boardState,
    bool? aiThinking,
    bool? flipBoard,
    List<String>? moveHistory,
  }) {
    return GameInProgress(
      boardState: boardState ?? this.boardState,
      aiThinking: aiThinking ?? this.aiThinking,
      flipBoard: flipBoard ?? this.flipBoard,
      moveHistory: moveHistory ?? this.moveHistory,
    );
  }
}
