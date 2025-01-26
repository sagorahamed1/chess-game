import 'package:bishop/bishop.dart' as bishop;
import 'package:chess/bloc/game/game_state.dart';
import 'package:squares/squares.dart' as squares;

import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:square_bishop/square_bishop.dart';

import 'package:squares/squares.dart';
import 'package:chess/bloc/game/game_state.dart' as bloc;

import 'game_event.dart';



class GameBloc extends Bloc<GameEvent, bloc.GameState> {
  late bishop.Game game;

  GameBloc() : super(GameInitial()) {
    game = bishop.Game(variant: bishop.Variant.standard());
    on<StartNewGame>((event, emit) => _startNewGame(emit));
    on<FlipBoard>((event, emit) => _flipBoard(emit));
    on<MakeMove>((event, emit) async => await _makeMove(event.move as squares.Move, emit));
    on<AiMove>((event, emit) async => await _makeAiMove(emit));
  }

  void _startNewGame(Emitter<bloc.GameState> emit) {
    game = bishop.Game(variant: bishop.Variant.standard());
    emit(GameInProgress(
      boardState: game.squaresState(Squares.white),
      moveHistory: [],
    ));
  }

  void _flipBoard(Emitter<bloc.GameState> emit) {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;
      emit(currentState.copyWith(flipBoard: !currentState.flipBoard));
    }
  }

  Future<void> _makeMove(squares.Move move, Emitter<bloc.GameState> emit) async {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;
      final result = game.makeSquaresMove(move); // Ensure this move is valid

      if (result) {
        final newBoardState = game.squaresState(Squares.white);
        final newHistory = List<String>.from(currentState.moveHistory)
          ..add('${move.piece ?? "Unknown"} from ${move.from} to ${move.to}');


        emit(currentState.copyWith(
          boardState: newBoardState,
          moveHistory: newHistory,
        ));

        if (newBoardState.state == PlayState.theirTurn) {
          add(AiMove());
        }
      }
    }
  }

  Future<void> _makeAiMove(Emitter<bloc.GameState> emit) async {
    if (state is GameInProgress) {
      final currentState = state as GameInProgress;

      emit(currentState.copyWith(aiThinking: true));
      await Future.delayed(
        Duration(milliseconds: Random().nextInt(4750) + 250),
      );

      game.makeRandomMove();
      final newBoardState = game.squaresState(Squares.white);
      emit(currentState.copyWith(
        boardState: newBoardState,
        aiThinking: false,
      ));
    }
  }
}
