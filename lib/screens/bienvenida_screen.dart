import 'package:flutter/material.dart';
import '../models/usuario_model.dart';

class BienvenidaScreen extends StatelessWidget {
  final Usuario usuario;

  const BienvenidaScreen({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    final bool esDocente = usuario.rol.toLowerCase() == 'docente';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 24),
            Text(
              '¡Bienvenid@, ${usuario.nombre}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              esDocente ? 'Docente' : 'Alumno',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Desde el menú puedes acceder a todas las funciones principales.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
