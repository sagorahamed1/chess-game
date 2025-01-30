import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_options.dart';
import '../helpers/toast_message.dart';

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




  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///======Firebase Initialization=======>
  static Future<void> setUpFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }






  ///=====Sign Up=====>
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('===> ${userCredential.user}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ToastMessageHelper.showToastMessage('The email address is already in use by another account.');
        debugPrint("The email address is already in use by another account.");
      } else {
        debugPrint("Registration Error: $e");
      }
      return null;
    } catch (e) {
      debugPrint("Registration Error: $e");
      return null;
    }
  }



  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastMessageHelper.showToastMessage('User not found!');
      } else if (e.code == 'wrong-password') {
        ToastMessageHelper.showToastMessage('Incorrect password!');
      } else {
        ToastMessageHelper.showToastMessage('User not found! $e');
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage('An unexpected error occurred: $e');
    }
    return null;
  }





  ///=====Sign Out====>
  Future<void> signOut() async {
    await _auth.signOut();
  }

  ///=======Store Data======>
  Future<void> postData(String userId, Map<String, dynamic> data, {String? collectionName}) async {
    try {
      await fireStore.collection(collectionName ?? 'users').doc(userId).set(data);
    } catch (e) {
      debugPrint("Save Data Error: $e");
    }
  }

  ///=======Store Data if Not Exists======
  Future<void> postDataIfNotExists(String userId, Map<String, dynamic> data, {String? collectionName}) async {
    try {
      // Reference to the document
      final docRef = fireStore.collection(collectionName ?? 'users').doc(userId);

      // Check if the document exists
      final docSnapshot = await docRef.get();

      // If the document does not exist, add the new data
      if (!docSnapshot.exists) {
        await docRef.set(data);
        debugPrint("Data posted successfully for user ID: $userId");
      } else {
        debugPrint("Document with user ID $userId already exists. Data not posted.");
      }
    } catch (e) {
      debugPrint("Save Data Error: $e");
    }
  }




  /// Store Data: Update list in Firestore
  Future<void> appendReviewToList(String userId, Map<String, dynamic> newReview, {String? collectionName}) async {
    try {
      DocumentReference docRef = fireStore.collection(collectionName ?? 'reviews').doc(userId);

      await fireStore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          transaction.set(docRef, {
            'reviewsList': [newReview],
          });
        } else {
          // Append new review to the existing list
          List<dynamic> reviewsList = snapshot.get('reviewsList') as List<dynamic>;
          reviewsList.add(newReview);
          transaction.update(docRef, {'reviewsList': reviewsList});
        }
      });
    } catch (e) {
      debugPrint("Error saving review to list: $e");
    }
  }



  ///==========Get Data======>
  Future<DocumentSnapshot> getData({required String id,required String collection }) async {
    try {
      return await fireStore.collection(collection).doc(id).get();
    } catch (e) {
      debugPrint("Get Data Error: $e");
      rethrow;
    }
  }


  ///========== Get All Data ======>
  Future<QuerySnapshot> getAllData({required String collection}) async {
    try {
      return await fireStore.collection(collection).get();
    } catch (e) {
      debugPrint("Get Data Error: $e");
      rethrow;
    }
  }



  ///=======Update Data======>
  Future<void> updateData(
      {required String userId,required String collection, required Map<String, dynamic> updatedData}) async {
    try {
      await fireStore.collection(collection).doc(userId).update(updatedData);
      debugPrint('Data updated successfully!');
    } catch (e) {
      debugPrint("Update Data Error: $e");
    }
  }


  ///=======Delete Data======>
  Future<void> deleteData({required String userId,required String collection}) async {
    try {
      await fireStore.collection(collection).doc(userId).delete();
      debugPrint('Data deleted successfully!');
    } catch (e) {
      debugPrint("Delete Data Error: $e");
    }
  }


}
