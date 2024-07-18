import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser(String name, String email, String password);
  Future<UserModel> loginUser(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> registerUser(
      String name, String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user != null) {
      final userModel = UserModel(uid: user.uid, name: name, email: email);
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return userModel;
    } else {
      throw Exception("User registration failed");
    }
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user != null) {
      final doc = await firestore.collection('users').doc(user.uid).get();
      return UserModel.fromMap(doc.data()!);
    } else {
      throw Exception("User login failed");
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
