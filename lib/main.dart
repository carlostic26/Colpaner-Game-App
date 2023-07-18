import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/dbexam.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/maestro/maestro_screen.dart';
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
  print('EMAIL LOGED IN: $email');

  //sharedPreferences init
  await LocalStorage.configurePrefs();

  //init db sqlite
  await SimulacroHandler().initializeDB();

  LocalStorage localStorage = LocalStorage();

  late bool isPin = false;
  print('ISPIN ANTES DE SHP: $isPin');

/*   Fluttertoast.showToast(
    msg: 'ISPIN ANTES DE SHP: $isPin', // message
    toastLength: Toast.LENGTH_LONG, // length
    gravity: ToastGravity.TOP, // location
  ); */

  isPin = await localStorage.getAccesPin();
  print('ISPIN DESPUES DE SHP: $isPin');

/*   Fluttertoast.showToast(
    msg: 'ISPIN DESPUES DE SHP: $isPin', // message
    toastLength: Toast.LENGTH_LONG, // length
    gravity: ToastGravity.TOP, // location
  ); */

  runApp(MaterialApp(
    routes: {
      '/pinScreen': (context) => const pinScreen(),
    },
    debugShowCheckedModeBanner: false,
    //si no existe un correo y si no se tiene el pin correcto, pasa a loginScreen
/*     home: email == null
        ? MyApp()
        : const entrenamientoModulos(),
 */
    home: email == null
        ? MyApp()
        : email == 'maestro@colpaner.app'
        ? Maestro_Screen()
        : (isPin == false)
            ? const pinScreen()
            : const entrenamientoModulos(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Iniciar Sesión',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
