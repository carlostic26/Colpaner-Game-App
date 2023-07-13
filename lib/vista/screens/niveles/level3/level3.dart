import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/modulos_soup/ciuda_soup.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/modulos_soup/ingles_soup.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/modulos_soup/lectura_soup.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/modulos_soup/mate_soup.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/modulos_soup/natu_soup.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class level3 extends StatefulWidget {
  const level3({super.key});

  @override
  State<level3> createState() => _level3State();
}

class _level3State extends State<level3> {
  String _modulo = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getModuloFromSharedPrefs();
  }

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
      openModuleScreen(_modulo);
    });
  }

  Future<void> openModuleScreen(String moduleName) async {
    if (moduleName == 'Razonamiento Cuantitativo') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const matesoup()),
      );
    } else if (moduleName == 'Inglés') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const inglessoup()),
      );
    } else if (moduleName == 'Lectura Crítica') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const lectusoup()),
      );
    } else if (moduleName == 'Ciencias Naturales') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const natusoup()),
      );
    } else if (moduleName == 'Competencias Ciudadanas') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ciudasoup()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colors_colpaner.base,
    );
  }
}
