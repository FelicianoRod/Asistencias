class PreguntaExamen {
  final int id;
  final String pregunta;
  final List<String> respuestas;
  final String respuestaCorrecta;
  final String respuestaAlumno;
  final String respuestaInciso;

  PreguntaExamen({
    required this.id,
    required this.pregunta,
    required this.respuestas,
    required this.respuestaCorrecta,
    required this.respuestaAlumno,
    required this.respuestaInciso
  });

  bool get esCorrecta => respuestaAlumno == respuestaCorrecta;
}
