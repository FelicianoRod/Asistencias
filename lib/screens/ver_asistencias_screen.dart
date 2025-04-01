import 'package:flutter/material.dart';

class VerAsistenciasScreen extends StatefulWidget {
  const VerAsistenciasScreen({super.key});

  @override
  State<VerAsistenciasScreen> createState() => _VerAsistenciasScreenState();
}

class _VerAsistenciasScreenState extends State<VerAsistenciasScreen> {
  final TextEditingController codigoController = TextEditingController();

  void _acceder() {
    final codigo = codigoController.text.trim();
    if (codigo.isNotEmpty) {
      // Aquí puedes navegar o validar el código
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código ingresado: $codigo')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingrese el código'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ingrese el código para tu asistencia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codigoController,
              decoration: InputDecoration(
                hintText: 'Ingrese el código',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _acceder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Registrar asistencia',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
