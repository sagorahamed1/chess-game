
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squares/squares.dart';
import '../../../bloc/game/game_bloc.dart';
import '../../../bloc/game/game_event.dart';
import '../../../bloc/game/game_state.dart';
import 'package:chess/bloc/game/game_state.dart' as bloc;



class PlayOnlineScreen extends StatelessWidget {
  const PlayOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(StartNewGame()),
      child: const PlayOnlinePage(),
    );
  }
}

class PlayOnlinePage extends StatelessWidget {
  const PlayOnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Online Chess'),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_left),
            onPressed: () {
              context.read<GameBloc>().add(FlipBoard());
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameBloc>().add(StartNewGame());
            },
          ),
        ],
      ),
      body: BlocBuilder<GameBloc, bloc. GameState>(
        builder: (context, state) {
          if (state is GameInProgress) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BoardController(
                      state: state.flipBoard
                          ? state.boardState.board.flipped()
                          : state.boardState.board,
                      playState: state.boardState.state,
                      pieceSet: PieceSet.merida(),
                      theme: BoardTheme.brown,
                      moves: state.boardState.moves,
                      onMove: (x) {
                         context.read<GameBloc>().add(MakeMove(x));
                      },
                      promotionBehaviour: PromotionBehaviour.autoPremove,
                      markerTheme: MarkerTheme(
                        empty: MarkerTheme.dot,
                        piece: MarkerTheme.corners(),
                      ),
                    ),
                  ),
                ),
                if (state.aiThinking)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      const Text(
                        'Move History',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...state.moveHistory.map(
                            (move) => ListTile(
                          title: Text(move),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
