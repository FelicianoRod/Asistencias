import 'package:app_asistencias/screens/detalle_alumnos_screen.dart';
import 'package:flutter/material.dart';

class InicioDocenteScreen extends StatelessWidget {
  final String nombreDocente;

  const InicioDocenteScreen({super.key, required this.nombreDocente});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
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
            ),
          ),

          // Lista de exámenes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Examen de Matemáticas'),
                subtitle: const Text('Semestre: 1 - Grupo: A'),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DetalleAlumnosScreen()),
                    );
                  },
                  child: const Text(
                    'Detalles',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
