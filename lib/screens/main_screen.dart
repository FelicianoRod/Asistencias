import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'materias_docente_screen.dart';

class MainScreen extends StatefulWidget {
  final String rol;
  const MainScreen({super.key, required this.rol});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final docenteOptions = [
    {'title': 'Materias Docente', 'icon': Icons.home},
    {'title': 'Registrar Asistencia', 'icon': Icons.check},
    {'title': 'Historial', 'icon': Icons.history},
  ];

  final alumnoOptions = [
    {'title': 'Inicio Alumno', 'icon': Icons.home},
    {'title': 'Ver Asistencias', 'icon': Icons.visibility},
  ];

  Widget _getContent() {
    if (widget.rol == 'docente') {
      if (currentIndex == 0) {
        return const InicioDocenteScreen(nombreDocente: 'Roldan Arcos Gonez');
      } else {
        return Center(
            child: Text(docenteOptions[currentIndex]['title'] as String));
      }
    } else {
      return Center(
          child: Text(alumnoOptions[currentIndex]['title'] as String));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDocente = widget.rol == 'docente';
    final menuOptions = isDocente ? docenteOptions : alumnoOptions;

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
                color: isDocente ? Colors.deepPurple : Colors.blue,
              ),
              child: Text(
                isDocente ? 'Menú Docente' : 'Menú Alumno',
                style: const TextStyle(color: Colors.white, fontSize: 24),
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
