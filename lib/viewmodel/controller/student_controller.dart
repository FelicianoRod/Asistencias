import 'package:app_asistencias/services/mysql/student_queries.dart';
import 'package:app_asistencias/viewmodel/provider/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentController {
  StudentQueries studentQueries = StudentQueries();

  Future<void> insertCode(BuildContext context, String code) async {
      //  ExamsProvider examsProvider = context.watch<ExamsProvider>();
      final userSession = context.read<UserSessionProvider>();  

  // Convertir el ID a entero de manera segura
  // final int? userId = int.tryParse(userSession.id);
  // if (userId == null) {
  //   throw Exception("ID de usuario inválido");
  // }

    int userId = int.parse(userSession.userSession?.id ?? '0');

    await studentQueries.insertCode(code, userId);
  }
}