import 'package:app_asistencias/models/alumno_examen_model.dart';
import 'package:app_asistencias/models/examen_model.dart';
import 'package:app_asistencias/models/pregunta_examen_model.dart';
import 'package:flutter/material.dart';

class ExamsProvider with ChangeNotifier {
  List<Examen> _exams = [];
  List<AlumnoExamen> _students = [];
  List<PreguntaExamen> _questions = [];

  List<Examen> get exams => _exams;

  List<AlumnoExamen> get students => _students;

  List<PreguntaExamen> get questions => _questions;

  Future<void> setExams({required List<Examen> exams}) async {
    _exams = exams;
    notifyListeners();
  }

  Future<void> setStudents({required List<AlumnoExamen> students}) async {
    _students = [];
    _students = students;
    notifyListeners();
  }

  Future<void> setQuestionsByStudent({required List<PreguntaExamen> questions}) async {
    _questions = questions;
    notifyListeners();
  }
}