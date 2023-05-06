import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/dbexam.dart';

import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/pin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //keep user loged in
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

//sharedPreferences init
  await LocalStorage.configurePrefs();

  //init db sqlite
  await SimulacroHandler().initializeDB();

  runApp(MaterialApp(
    routes: {
      '/pinScreen': (context) => const pinScreen(),
    },
    debugShowCheckedModeBanner: false,
    home: email == null ? MyApp() : const entrenamientoModulos(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iniciar Sesión',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
