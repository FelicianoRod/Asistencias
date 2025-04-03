import 'package:app_asistencias/services/mysql/connection.dart';

class NotiQueries {
  var db = Connection();

  Future<List<String>> getNotifications(int userId) async {
    List<String> notifications = [];
    var connection = await db.getConnection();

    try {
      var results = await connection.query('''
        SELECT codigo_asistencia.codigo
        FROM alumnos
        LEFT JOIN asistencias
        ON asistencias.alumno_id = alumnos.id
        LEFT JOIN codigo_asistencia
        ON codigo_asistencia.id = asistencias.codigo_asistencia_id
        WHERE alumnos.id = ?
      ''', [userId]);

      if (results.isNotEmpty) {
        notifications = results.map((row) => row.fields['codigo'].toString()).toList();
      } 
    } catch (e) {
      print('Error: $e');
    } finally {
      await connection.close();
    }

    return notifications;
  }

}