import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spag/services/firebase_auth_service.dart';
import 'package:spag/services/mongo_user_service.dart';

enum Role { user, gym }

// Definición de la clase abstracta
abstract class AbstractUser {
  static final FirebaseAuthService authService = FirebaseAuthService();

  ObjectId id;
  Role role;
  String name;
  String email;

  User? fireAuthUser;

  AbstractUser(
      {required this.id,
      required this.role,
      required this.name,
      required this.email});

  @nonVirtual
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "_id": id,
      "role": role.name,
      "name": name,
      "email": email,
    };
    return toJsonSpecific(json);
  }

  Map<String, dynamic> toJsonSpecific(Map<String, dynamic> generalJson);

  static Future<AbstractUser?> fromEmail(String email) async {
    return UserService.getByEmail(email);
  }

  @nonVirtual
  Future<bool> logIn(String password) async {
    fireAuthUser = await authService.logInWithEmailAndPassword(email, password);
    return fireAuthUser != null;
  }

  @nonVirtual
  Future<void> signUp(String password) async {
    fireAuthUser =
        await authService.signUpWithEmailAndPassword(email, password);
    if (fireAuthUser != null) {
      // Template method:
      insert();
    } else {
      print("Problem signing in a general user");
    }
  }

  Future<void> insert();

  bool isLogged() {
    return fireAuthUser != null;
  }

  @nonVirtual
  Future<void> signOut() async {
    await authService.signOut();
  }
}
