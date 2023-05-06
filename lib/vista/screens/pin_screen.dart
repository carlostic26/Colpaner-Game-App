import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class pinScreen extends StatefulWidget {
  const pinScreen({super.key});

  @override
  State<pinScreen> createState() => _pinScreenState();
}

class _pinScreenState extends State<pinScreen> {
  String pin = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: 0.5,
              //img background
              child: CachedNetworkImage(
                imageUrl:
                    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEguAew123nq51EReZ1giaM9ny73tC9h7o1RBXE2TVfIpQabivXCy9eyHhVXkO1E1aJCiad-wmwUflNL6rgF5x964401Nre6WBt0Av_VHEb55CCp483_o27TlGlXmCP_dul-3mdtC3fJSDhqCylnV0bQY9Ih04gf6bbam4Bcc_nHS-NoGXXcH-Gs9P8/s16000/1675262458900.jpg",
                height: 1000,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(children: [
                          const Text(
                            "Código de acceso\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "* Se requiere un pin de 5 dígitos para ingresar a la app. Si eres estudiante pregúntale al maestro encargado.",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: "Digita el pin de acceso"),
                            onChanged: (String value) {
                              setState(() {
                                pin = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20.0),
                          TextButton(
                            child: const Text("Ingresar"),
                            onPressed: () {
                              if (pin == '00000') {
                                //shared preferences pin=true
                                savePin(true);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const entrenamientoModulos()),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Pin incorrecto", // message
                                  toastLength: Toast.LENGTH_SHORT, // length
                                  gravity: ToastGravity.CENTER, // location
                                );
                              }
                            },
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Guardar el acceso de pin en SharedPreferences
Future<void> savePin(bool pin) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('pin', pin);
}

// Leer un valor de SharedPreferences
Future<bool> getPin() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('pin') ?? false;
}

/* Future<void> _checkPinStatus() async {
  bool pinStatus = await getPin();
  if (pinStatus) {
    Navigator.pushNamed(context, '/your-screen-route');
  } else {
    // Mostrar la pantalla de ingreso de pin o hacer algo más aquí
  }
}
 */