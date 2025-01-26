


import 'package:squares/squares.dart';

abstract class GameEvent {}

class StartNewGame extends GameEvent {}

class FlipBoard extends GameEvent {}

class MakeMove extends GameEvent {
  final Move move;

  MakeMove(this.move);
}

class AiMove extends GameEvent {}