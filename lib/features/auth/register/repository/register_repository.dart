import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;

  RegisterRepository(this._auth, this.firestore);

  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firestore.collection("users").doc(user.user!.uid).set({
        "username": username,
        "email": email,
        "uid": user.user!.uid,
      });
      return const Right("Successfully register...");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
