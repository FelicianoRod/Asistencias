import 'package:app_asistencias/models/user_credential.dart';
import 'package:app_asistencias/models/user_session.dart';
import 'package:app_asistencias/services/mysql/connection.dart';

class AuthenticationQueries {
  var db = Connection();

  Future<UserSession?> getUser(UserCredential userCredential) async {
    UserSession? user;
    var connection = await db.getConnection();

    try {
      var student = await connection.query('''
        SELECT id, nombre, matricula, password
        FROM alumnos
        WHERE matricula = ?
      ''', [userCredential.identifier]);

      var teacher = await connection.query('''
        SELECT id, name, email, rol, password
        FROM users
        WHERE email = ?
      ''', [userCredential.identifier]);

      if (student.isNotEmpty) {
        user = UserSession(
          id: student.first.fields['id'].toString(), 
          name: student.first.fields['nombre'].toString(), 
          role: 'student',
          password: student.first.fields['password'].toString(),
        );
      } else if (teacher.isNotEmpty) {
        user = UserSession(
          id: teacher.first.fields['id'].toString(), 
          name: teacher.first.fields['name'].toString(), 
          role: teacher.first.fields['rol'].toString(),
          email: teacher.first.fields['email'].toString(),
          password: teacher.first.fields['password'].toString(),
        );
      } else {
        user = null;
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connection.close();
    }

    return user;
  }
}