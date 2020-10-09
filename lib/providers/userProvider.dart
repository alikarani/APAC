import 'package:Behind_APAC/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserData _userData;
  UserProvider.initialize();

  UserData get userData => _userData;

  setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}
