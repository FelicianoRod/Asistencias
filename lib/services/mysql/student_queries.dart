import 'package:app_asistencias/services/mysql/connection.dart';

class StudentQueries {
  var db = Connection();

  Future<void> insertCode(String code, int userId) async {
    var connection = await db.getConnection();
    try {
      var result = await connection.query('''
        SELECT id
        FROM codigo_asistencia
        WHERE codigo = ?
      ''', [code]);

      int id = result.first.fields['id'];
      DateTime now = DateTime.now().toUtc();  // ✅ Convierte la fecha a UTC


      var insert = await connection.query('''
        INSERT INTO asistencias (alumno_id, codigo_asistencia_id, fecha, estado)
        VALUES (?, ?, ?, "presente")
      ''', [userId, id, now]);
      print("hecho");
    } catch (e) {
      print("Error: $e");
    }
  }
}