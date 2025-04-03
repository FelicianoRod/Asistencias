import 'package:app_asistencias/services/mysql/teaching_queries.dart';
import 'package:app_asistencias/viewmodel/provider/exams_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamsController {
  TeachingQueries teachingQueries = TeachingQueries();

  Future<void> getExams(BuildContext context) async {
    var exams = await teachingQueries.getExams();

    if (exams != null) {
      context.read<ExamsProvider>().setExams(exams: exams);
    } else {
      print('No se encontraron exámenes.');
    }
  }

  Future<void> getStudentsByExam(BuildContext context, int examId) async {
    var students = await teachingQueries.getStudentsByExam(examId);

    if (students != null) {
      context.read<ExamsProvider>().setStudents(students: students);
    } else {
      print('No se encontraron alumnos para el examen con ID $examId.');
    }
  }

  Future<void> getExamsByStuden(BuildContext context, int studentId) async {
    var questions = await teachingQueries.getExamQuestions(studentId);

    if (questions != null) {
      context.read<ExamsProvider>().setQuestionsByStudent(questions: questions);
    } else {
      print('No se encontraron preguntas para el examen del alumno con ID $studentId.');
    }
  }
}