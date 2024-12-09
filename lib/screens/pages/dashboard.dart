import 'package:flutter/material.dart';
import 'package:myapp/models/categoria_model.dart' as categoria_model;
import 'package:myapp/models/usuario_model.dart';
import 'package:myapp/models/cita_model.dart';
import 'package:myapp/models/producto_model.dart';
import 'package:myapp/models/venta_model.dart';
import 'package:myapp/services/categoria_service.dart';
import 'package:myapp/services/usuario_service.dart';
import 'package:myapp/services/cita_service.dart';
import 'package:myapp/services/producto_service.dart';
import 'package:myapp/services/venta_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int activeUsuariosCount = 0;
  int activeCategoriasCount = 0;
  int activeCitasCount = 0;
  int activeProductosCount = 0;
  int activeVentasCount = 0;

  Future<void> _getActiveUsuarios() async {
    try {
      List<Usuario> activeUsuarios = await ApiServiceUsuario.getActiveUsuarios();
      setState(() {
        activeUsuariosCount = activeUsuarios.length;
      });
    } catch (e) {
      print('Error fetching active usuarios: $e');
    }
  }

  Future<void> _getActiveCategorias() async {
    try {
      List<categoria_model.Categoria> activeCategorias = await ApiServiceCategoria.listarCategoriasPorEstado("A");
      setState(() {
        activeCategoriasCount = activeCategorias.length;
      });
    } catch (e) {
      print('Error fetching active categorias: $e');
    }
  }

  Future<void> _getActiveCitas() async {
    try {
      List<Cita> activeCitas = await ApiServiceCita.listarCitas();
      setState(() {
        activeCitasCount = activeCitas.length;
      });
    } catch (e) {
      print('Error fetching active citas: $e');
    }
  }

  Future<void> _getActiveProductos() async {
    try {
      List<Producto> activeProductos = await ApiServiceProducto.listarProductos();
      setState(() {
        activeProductosCount = activeProductos.length;
      });
    } catch (e) {
      print('Error fetching active productos: $e');
    }
  }

  Future<void> _getActiveVentas() async {
    try {
      List<Venta> activeVentas = await VentaService.getActiveVentas();
      setState(() {
        activeVentasCount = activeVentas.length;
      });
    } catch (e) {
      print('Error fetching active ventas: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getActiveUsuarios();
    _getActiveCategorias();
    _getActiveCitas();
    _getActiveProductos();
    _getActiveVentas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('Usuarios', activeUsuariosCount, Icons.people, Colors.blue),
                  _buildStatCard('Categorías', activeCategoriasCount, Icons.category, Colors.teal),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('Citas', activeCitasCount, Icons.calendar_today, Colors.orange),
                  _buildStatCard('Productos', activeProductosCount, Icons.shopping_basket, Colors.green),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('Ventas', activeVentasCount, Icons.attach_money, Colors.deepPurple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData iconData, Color color) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}