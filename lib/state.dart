import 'package:flutter/material.dart';

enum AuthStateEnum { unknown, authenticated, unauthenticated }

class AuthState extends ChangeNotifier {
  AuthStateEnum stateEnum = AuthStateEnum.unknown;

  setAuthStatus(AuthStateEnum authStateEnum) {
    stateEnum = authStateEnum;
    notifyListeners();
  }
}
