import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _auth;

  LoginRepository(this._auth);

  Future<Either<String, String>> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Right("Successfully Login...");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
