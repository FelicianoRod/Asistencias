class PreguntaExamen {
  final String pregunta;
  final List<String> respuestas;
  final String respuestaCorrecta;
  final String respuestaAlumno;

  PreguntaExamen({
    required this.pregunta,
    required this.respuestas,
    required this.respuestaCorrecta,
    required this.respuestaAlumno,
  });

  bool get esCorrecta => respuestaAlumno == respuestaCorrecta;
}
