import 'package:flutter/material.dart';
import 'package:spag/models/users/abstract_user.dart';

class UserProvider with ChangeNotifier {
  AbstractUser? _user;
  bool _hasUser = false;

  AbstractUser? get user => _user;
  set user(AbstractUser? user) {
    _user = user;
    if (user != null) {
      _hasUser = true;
    } else {
      _hasUser = false;
      print("Deslogueado el provider");
    }
    notifyListeners();
  }

  bool get hasUser => _hasUser;

  void signOut() {
    user = null;
  }
}
