import 'package:app_asistencias/models/user_session.dart';
import 'package:flutter/material.dart';

class UserSessionProvider  with ChangeNotifier {
  UserSession? userSession; 

  UserSession? get getUserSession => userSession;

  Future<void> setUserSession({required UserSession userSession}) async {
    this.userSession = userSession;
    notifyListeners;
  }
}