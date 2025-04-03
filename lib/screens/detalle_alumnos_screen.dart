import 'package:app_asistencias/models/examen_model.dart';
import 'package:app_asistencias/viewmodel/controller/exams_controller.dart';
import 'package:app_asistencias/viewmodel/provider/exams_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ver_examen_screen.dart';

class AlumnoExamen {
  final String nombre;
  final String materia;
  final String grupo;
  final int semestre;
  final int aciertos;

  AlumnoExamen({
    required this.nombre,
    required this.materia,
    required this.grupo,
    required this.semestre,
    required this.aciertos,
  });
}

class DetalleAlumnosScreen extends StatelessWidget {
  final Examen examen;
  ExamsController examsController = ExamsController();

  DetalleAlumnosScreen({super.key, required this.examen});

  @override
  Widget build(BuildContext context) {
    // final List<AlumnoExamen> alumnos = [
    //   AlumnoExamen(
    //     nombre: 'Roldan Arcos Gomez',
    //     materia: 'Matemáticas',
    //     grupo: 'A',
    //     semestre: 1,
    //     aciertos: 2,
    //   ),
    //   AlumnoExamen(
    //     nombre: 'Luis Pérez Castillo',
    //     materia: 'Matemáticas',
    //     grupo: 'A',
    //     semestre: 1,
    //     aciertos: 4,
    //   ),
    //   AlumnoExamen(
    //     nombre: 'Ana López Ramírez',
    //     materia: 'Matemáticas',
    //     grupo: 'A',
    //     semestre: 1,
    //     aciertos: 3,
    //   ),
    // ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Alumnos - Matemáticas',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder(
        future: examsController.getStudentsByExam(context, examen.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error, intenete más tarde."));
          } 

          ExamsProvider examsProvider = context.watch<ExamsProvider>();
          if (examsProvider.students.isEmpty) {
            return const Center(child: Text("No hay alumnos registrados."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: examsProvider.students.length,
            itemBuilder: (context, index) {
              final alumno = examsProvider.students[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    alumno.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('Aciertos: ${alumno.aciertos}'),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerExamenScreen(
                            id: alumno.id,
                            alumno: alumno.nombre,
                            materia: examen.titulo,
                            grupo: alumno.grupo,
                            semestre: alumno.semestre,
                          ),
                        ),
                      );
                    },
                    child: const Text('Ver Examen'),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
