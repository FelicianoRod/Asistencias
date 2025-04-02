import 'package:app_asistencias/models/usuario_model.dart';
import 'package:app_asistencias/screens/bienvenida_screen.dart';
import 'package:app_asistencias/screens/ver_asistencias_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'materias_docente_screen.dart';

class MainScreen extends StatefulWidget {
  final Usuario usuario;

  const MainScreen({super.key, required this.usuario});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final docenteOptions = [
    {'title': 'Inicio', 'icon': Icons.home},
    {'title': 'Materias del docente', 'icon': Icons.book},
  ];

  final alumnoOptions = [
    {'title': 'Inicio', 'icon': Icons.home},
    {'title': 'Registra tu asistencia', 'icon': Icons.visibility},
  ];

  Widget _getContent() {
    final esDocente = widget.usuario.rol == 'docente';

    if (esDocente) {
      if (currentIndex == 0) {
        return BienvenidaScreen(usuario: widget.usuario);
      } else if (currentIndex == 1) {
        return MateriaDocenteScreen(nombreDocente: widget.usuario.nombre);
      } else {
        return Center(
          child: Text(
            docenteOptions[currentIndex]['title'] as String,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }
    } else {
      if (currentIndex == 0) {
        return BienvenidaScreen(usuario: widget.usuario);
      } else if (currentIndex == 1) {
        return VerAsistenciasScreen();
      } else {
        return Center(
          child: Text(
            alumnoOptions[currentIndex]['title'] as String,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final esDocente = widget.usuario.rol == 'docente';
    final menuOptions = esDocente ? docenteOptions : alumnoOptions;

    return Scaffold(
      appBar: AppBar(
        title: Text(menuOptions[currentIndex]['title'] as String),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: esDocente ? Colors.deepPurple : Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.usuario.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    esDocente ? 'Docente' : 'Alumno',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ...menuOptions.asMap().entries.map((entry) {
              int i = entry.key;
              var item = entry.value;
              return ListTile(
                leading: Icon(item['icon'] as IconData),
                title: Text(item['title'] as String),
                onTap: () {
                  setState(() => currentIndex = i);
                  Navigator.pop(context);
                },
              );
            }).toList(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: _getContent(),
    );
  }
}
