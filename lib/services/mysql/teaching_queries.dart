import 'package:app_asistencias/models/alumno_examen_model.dart';
import 'package:app_asistencias/models/examen_model.dart';
import 'package:app_asistencias/models/pregunta_examen_model.dart';
import 'package:app_asistencias/services/mysql/connection.dart';

class TeachingQueries {
  var db = Connection();

  Future<List<Examen>?> getExams() async {
    List<Examen>? exams = [];
    var connection = await db.getConnection();

    try {
      var results = await connection.query('''
        SELECT examenes.id_examen, materias.materia, 
        examenes.semestre, examenes.grupo
        FROM examenes
        LEFT JOIN materias
        ON materias.id = examenes.materia_id
      ''');

      if (results.isNotEmpty) {
        exams = results.map((row) {
          return Examen(
            id: row.fields['id_examen'],
            titulo: row.fields['materia'].toString(),
            semestre: row.fields['semestre'],
            grupo: row.fields['grupo'].toString(),
          );
        }).toList();
      } else {
        exams = null;
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connection.close();
    }

    return exams;
  }
  
  Future<List<AlumnoExamen>> getStudentsByExam(int examId) async {
    List<AlumnoExamen> students = [];
    var connection = await db.getConnection();

    try {
      var results = await connection.query('''
        SELECT alumnos.id, 
        alumnos.nombre, 
        alumnos.grupo, 
        alumnos.semestre, 
        examen_alumno.total_aciertos
        FROM examen_alumno
        LEFT JOIN alumnos
        ON alumnos.id = examen_alumno.id_alumno
        WHERE examen_alumno.id_examen = ?
      ''', [examId]);

      if (results.isNotEmpty) {
        students = results.map((row) {
          return AlumnoExamen(
            id: row.fields['id'],
            nombre: row.fields['nombre'].toString(),
            grupo: row.fields['grupo'].toString(),
            semestre: row.fields['semestre'],
            aciertos: row.fields['total_aciertos'],
          );
        }).toList();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connection.close();
    }

    return students;
  }

  Future<List<PreguntaExamen>?> getExamQuestions(int examId) async {
    List<PreguntaExamen> questions = [];
    var connection = await db.getConnection();

    try {
      var results = await connection.query('''
        SELECT respuestas_alumno.id,
        preguntas.texto_pregunta,
        respuestas.texto_respuesta,
        respuestas.inciso,
        respuestas_alumno.inciso,
        preguntas.respuesta_correcta
        FROM examen_alumno
        INNER JOIN respuestas_alumno
        ON respuestas_alumno.id_examen_alumno = examen_alumno.id
        INNER JOIN preguntas
        ON preguntas.id_pregunta = respuestas_alumno.id_pregunta
        INNER JOIN respuestas
        ON respuestas.id_pregunta = preguntas.id_pregunta
        WHERE examen_alumno.id_alumno = ? AND examen_alumno.id IS NOT NULL
      ''', [examId]);

      int idQuestion = -1;
      String question = '';
      List<String> optinos = [];
      String correctAnswer = '';
      String studentAnswer = '';
      String answerInciso = '';

      for (var currentRow in results) {
        if (idQuestion != -1 && idQuestion != currentRow[0]) {
          questions.add(
            PreguntaExamen(
              id: idQuestion,
              pregunta: question,
              respuestas: optinos,
              respuestaCorrecta: correctAnswer,
              respuestaAlumno: studentAnswer,
              respuestaInciso: answerInciso,
            ),
          );
          optinos.clear();
        }
        if (idQuestion != currentRow[0]) {
          question = currentRow[1].toString();
          optinos.add(currentRow[2].toString());
          correctAnswer = currentRow[3].toString();
          // correctAnswer = currentRow[5].toString();
          studentAnswer = currentRow[4].toString();
          answerInciso = currentRow[5].toString();
          idQuestion = currentRow[0];
        } else {
          optinos.add(currentRow[2].toString());
        }
      }
      if (idQuestion != -1) {
        questions.add(
          PreguntaExamen(
            id: idQuestion,
            pregunta: question,
            respuestas: optinos,
            respuestaCorrecta: correctAnswer,
            // respuestaCorrecta: answerInciso,
            respuestaAlumno: studentAnswer,
            respuestaInciso: answerInciso,
          ),
        );
      }

    } catch (e) {
      print("Aquí");
      print('Error: $e');
    } finally {
      await connection.close();
    }
    print(questions.length);
    return questions;
  }
}