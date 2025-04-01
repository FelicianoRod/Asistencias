import 'package:flutter/material.dart';

class VerExamenScreen extends StatelessWidget {
  final String alumno;
  final String materia;
  final String grupo;
  final int semestre;

  const VerExamenScreen({
    super.key,
    required this.alumno,
    required this.materia,
    required this.grupo,
    required this.semestre,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> preguntas = [
      {
        'pregunta': '¿Cuánto es 2 + 2?',
        'respuestas': ['3', '4', '5', '6'],
        'respuestaCorrecta': '4',
        'respuestaAlumno': '4',
      },
      {
        'pregunta': '¿Cuál es la capital de Francia?',
        'respuestas': ['Madrid', 'Berlín', 'París', 'Roma'],
        'respuestaCorrecta': 'París',
        'respuestaAlumno': 'Madrid',
      },
      {
        'pregunta': '¿Qué planeta es conocido como el planeta rojo?',
        'respuestas': ['Marte', 'Venus', 'Júpiter', 'Saturno'],
        'respuestaCorrecta': 'Marte',
        'respuestaAlumno': 'Marte',
      },
    ];

    // Contadores de aciertos y errores
    int aciertos = preguntas
        .where((p) => p['respuestaAlumno'] == p['respuestaCorrecta'])
        .length;
    int errores = preguntas.length - aciertos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Examen - $materia'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Alumno: $alumno', style: const TextStyle(fontSize: 18)),
          Text('Semestre: $semestre - Grupo: $grupo',
              style: const TextStyle(fontSize: 16)),
          const Divider(height: 32),
          const Text(
            'Respuestas del Examen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...preguntas.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final pregunta = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pregunta $index: ${pregunta['pregunta']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...pregunta['respuestas'].map<Widget>((opcion) {
                      final esSeleccionada =
                          opcion == pregunta['respuestaAlumno'];
                      final esCorrecta =
                          opcion == pregunta['respuestaCorrecta'];
                      Icon? icono;

                      if (esSeleccionada && esCorrecta) {
                        icono =
                            const Icon(Icons.check_circle, color: Colors.green);
                      } else if (esSeleccionada && !esCorrecta) {
                        icono = const Icon(Icons.cancel, color: Colors.red);
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: esSeleccionada
                              ? (esCorrecta ? Colors.green[50] : Colors.red[50])
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(opcion)),
                            if (icono != null) icono,
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          const Divider(thickness: 1),
          Center(
            child: Column(
              children: [
                Text('✅ Aciertos: $aciertos',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('❌ Errores: $errores',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
