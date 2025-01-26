import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> createGame(String player1) async {
    return await _firestore.collection('games').add({
      'player1': player1,
      'player2': null,
      'moves': [],
      'turn': 'white',
      'winner': null,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> joinGame(String gameId, String player2) async {
    await _firestore.collection('games').doc(gameId).update({
      'player2': player2,
    });
  }

  Stream<DocumentSnapshot> gameStream(String gameId) {
    return _firestore.collection('games').doc(gameId).snapshots();
  }

  Future<void> updateMoves(String gameId, List<Map<String, dynamic>> moves, String turn) async {
    await _firestore.collection('games').doc(gameId).update({
      'moves': moves,
      'turn': turn,
    });
  }

  Future<void> declareWinner(String gameId, String winner) async {
    await _firestore.collection('games').doc(gameId).update({
      'winner': winner,
    });
  }
}
