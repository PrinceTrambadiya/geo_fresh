import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  set userModel(UserModel value) {
    _userModel = value;
    notifyListeners();
  }

  UserModel get userModel => _userModel;
}
