
import 'package:app_asistencias/models/user_credential.dart';
import 'package:app_asistencias/models/usuario_model.dart';
import 'package:app_asistencias/screens/main_screen.dart';
import 'package:app_asistencias/services/mysql/auth_queries.dart';
import 'package:app_asistencias/viewmodel/controller/noti_controller.dart';
import 'package:app_asistencias/viewmodel/provider/user_session_provider.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationController {
  AuthenticationQueries authenticationQueries = AuthenticationQueries();
  // NotificationController notificationController = NotificationController();
  NotiController notiController = NotiController();

  Future<void> login(BuildContext context, String identifier, String password) async {
    UserCredential userCrential = UserCredential(
      identifier: identifier,
      password: password,
    );

    var result = await authenticationQueries.getUser(userCrential);

    // Validar contraseña
    // bool passwordValid = false;
    if (result != null) {
      var passwordCheck = await BCrypt.checkpw(password, result.password);
      if (passwordCheck) {
        context.read<UserSessionProvider>().setUserSession(userSession: result);
          
        final usuario = Usuario(
          correo: result.name,
          contrasena: result.password,
          nombre: result.name,
          rol: result.role,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(usuario: usuario),
          ),
        );

        notiController.showNotificacion(int.parse(result.id));
      } else {
        print("password no valido");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Verifica tu información ❌"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }



    // if (result?.role == 3) {
    //   notificationController.showNotification();
    // }
  }

  
  // Future<void> logout(BuildContext context) async {
  //   context.read<AuthenticationProvider>().setUserCredential(userCredentialP: null);
  // }
}