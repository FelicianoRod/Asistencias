import 'package:app_asistencias/screens/detalle_alumnos_screen.dart';
import 'package:app_asistencias/viewmodel/controller/exams_controller.dart';
import 'package:app_asistencias/viewmodel/provider/exams_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class Examen {
//   final String titulo;
//   final int semestre;
//   final String grupo;

//   Examen({
//     required this.titulo,
//     required this.semestre,
//     required this.grupo,
//   });
// }

class MateriaDocenteScreen extends StatelessWidget {
  final String nombreDocente;
  ExamsController examsController = ExamsController();

  MateriaDocenteScreen({super.key, required this.nombreDocente});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();


    // final List<Examen> examenes = [
    //   Examen(titulo: 'Examen de Matemáticas', semestre: 1, grupo: 'A'),
    //   Examen(titulo: 'Examen de Física', semestre: 2, grupo: 'B'),
    //   Examen(titulo: 'Examen de Química', semestre: 3, grupo: 'C'),
    // ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<void>(
        future: examsController.getExams(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error, intenete más tarde."));
          } 
          // else if (examsProvider.exams == null) {
          //   return const Center(child: Text("No hay exámenes disponibles."));
          // }

          ExamsProvider examsProvider = context.watch<ExamsProvider>();


          return Column(
            children: [
              // Campo de búsqueda
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar examen...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // En versiones futuras puedes implementar el filtrado aquí
                  },
                ),
              ),
          
              // Lista de exámenes
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: examsProvider.exams.length,
                  itemBuilder: (context, index) {
                    final examen = examsProvider.exams[index];
          
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text('Examen de ${examen.titulo}'),
                        subtitle: Text(
                            'Semestre: ${examen.semestre} - Grupo: ${examen.grupo}'),
                        trailing: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetalleAlumnosScreen(
                                  examen: examen
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Detalles',
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
