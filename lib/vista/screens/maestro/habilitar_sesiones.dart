import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/maestro/drawer_maestro.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabilitarSesiones extends StatefulWidget {
  const HabilitarSesiones({super.key});

  @override
  State<HabilitarSesiones> createState() => _HabilitarSesionesState();
}

Color _switchActiveColor =
    Colors.white; // Puedes cambiar el color aquí al que desees

class _HabilitarSesionesState extends State<HabilitarSesiones> {
  bool _habilitarSesion = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // StreamController para escuchar los cambios en el valor de sesion_habilitar
  final StreamController<bool> _sesionHabilitarStreamController =
      StreamController<bool>.broadcast();

// Stream para emitir los cambios de sesion_habilitar
  Stream<bool> get sesionHabilitarStream =>
      _sesionHabilitarStreamController.stream;

  @override
  void initState() {
    super.initState();
    getSesion();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });
  }

  Future<void> setSesion(bool value) async {
    final setSesion =
        FirebaseFirestore.instance.collection('sesion').doc('habilitar');

    await setSesion.set({'sesion_habilitar': value});

    // Notificar a través del Stream que el valor ha cambiado
    _sesionHabilitarStreamController.add(value);
  }

  Future<void> getSesion() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('sesion')
        .doc('habilitar')
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('sesion_habilitar')) {
        _habilitarSesion = data['sesion_habilitar'] as bool;
      }
    }

    // Notificar a través del Stream que el valor ha cambiado
    _sesionHabilitarStreamController.add(_habilitarSesion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        title: const Text(
          "Acesso a la app",
          style: TextStyle(
            fontSize: 16.0,
            color: colors_colpaner.claro,
            /*fontWeight: FontWeight.bold*/
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.transparent, // establece el color de fondo transparente
        elevation: 0, // elimina la sombra
        iconTheme: const IconThemeData(
            color: colors_colpaner
                .claro), // cambia el color del icono del botón de menú lateral a negro
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Habilitar acceso a los estudiantes',
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'BubblegumSans',
                  fontWeight: FontWeight.bold,
                  color: colors_colpaner
                      .claro // Cambié "colors_colpaner.oscuro" a Colors.black
                  ),
            ),
            StreamBuilder<bool>(
              stream: sesionHabilitarStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool sesionHabilitar = snapshot.data!;
                  return Switch(
                    value: sesionHabilitar,
                    onChanged: (value) {
                      if (value) {
                        Fluttertoast.showToast(
                          msg: 'Acceso activado', // message
                          toastLength: Toast.LENGTH_LONG, // length
                          gravity: ToastGravity.BOTTOM, // location
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Acceso desactivado', // message
                          toastLength: Toast.LENGTH_LONG, // length
                          gravity: ToastGravity.BOTTOM, // location
                        );
                      }
                      setState(() {
                        // Cambiar el valor de sesion_habilitar cuando el usuario active o desactive el Switch
                        setSesion(value);
                      });
                    },
                    activeColor: _switchActiveColor,
                  );
                } else {
                  // Manejar el caso cuando no hay datos
                  return CircularProgressIndicator(); // O cualquier otro indicador de carga
                }
              },
            )
          ],
        ),
      ),
      drawer: DrawerMaestro(
        context: context,
        screen: 'sesion',
      ),
    );
  }
}
