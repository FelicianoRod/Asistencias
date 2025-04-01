import 'package:app_asistencias/screens/ver_examen_screen.dart';
import 'package:flutter/material.dart';

class DetalleAlumnosScreen extends StatelessWidget {
  const DetalleAlumnosScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
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
              title: const Text(
                'Roldan Arcos Gomez',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: const [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('Aciertos: 2'),
                ],
              ),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VerExamenScreen(
                        alumno: 'Roldan Arcos Gomez',
                        materia: 'Matemáticas',
                        grupo: 'A',
                        semestre: 1,
                      ),
                    ),
                  );
                },
                child: const Text('Ver Examen'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
