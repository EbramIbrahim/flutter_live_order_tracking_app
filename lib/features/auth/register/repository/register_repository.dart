import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseAuth _auth;

  RegisterRepository(this._auth);

  Future<Either<String, String>> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right("Successfully register...");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
