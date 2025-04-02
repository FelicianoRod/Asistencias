class Usuario {
  final String correo;
  final String contrasena;
  final String nombre;
  final String rol; // 'docente' o 'alumno'

  Usuario({
    required this.correo,
    required this.contrasena,
    required this.nombre,
    required this.rol,
  });
}
