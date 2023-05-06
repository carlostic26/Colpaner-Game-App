import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';

import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class level6 extends StatefulWidget {
  const level6({super.key});

  @override
  State<level6> createState() => _level6State();
}

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 24,
  color: Colors.white,
);

class _level6State extends State<level6> {
  String _message = "";
  int _timeLeft = 6;

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
          switch (_timeLeft) {
            case 4:
              _message = "Comenzamos en";
              break;
            case 3:
              _message = "3...";
              break;
            case 2:
              _message = "2...";
              break;
            case 1:
              _message = "1...";
              break;
            default:
              _message = "¿Preparado?";
          }
        });
        _startCountdown();
      } else {
        setState(() {
          _message = "¡Empecemos!";
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _message = "";
          });
        });
      }
    });
  }

  bool? seleccion;
  bool _allAfirmacionesShown = false;
  int _currentAfirmacionIndex = 0;
  Color _verdaderoButtonColor = Colors.black;
  Color _falsoButtonColor = Colors.black;

  bool trueButton = false;
  bool falseButton = false;

  Map<String, bool> afirmaciones = {
    "El sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "El agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Los pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "El sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "El agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Los pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Ele sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "Ele agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Lose pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Elee sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "Elr agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Los33 pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Ele3 sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "Ele3 agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "Los3e pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
  };

  Map<String, bool> afirmacionesMAT = {
    "MAT El sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "MAT agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT  pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT El sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "MAT El agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Los pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Ele sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "MAT Ele agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Lose pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Elee sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "MAT Elr agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Los33 pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Ele3 sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "MAT Ele3 agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "MAT Los3e pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
  };

  Map<String, bool> afirmacionesING = {
    "ING El sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "ING El agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Los pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING El sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "ING El agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Los pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Ele sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "ING Ele agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Lose pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Elee sole es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "ING Elr agua hiervee a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Los33 pingüinose pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Ele3 sol es una estrella fdgdf gdfg zdfgczsfgzsdgdg csdfsdcg History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        true,
    "ING Ele3 agua hierve a 70 grados Celsius History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
    "ING Los3e pingüinos pueden volar History is temporarily unavailable. We're working to restore this feature as soon as possible.":
        false,
  };

  Map<String, bool> diezAfirmaciones = {};

//obtiene solo 10 afirmaciones de la cantidad total del mapa de afirmaciones
  Map<String, bool> obtenerAfirmacionesAleatorias(
      Map<String, bool> afirmaciones) {
    final random = Random();
    final afirmacionesKeys = afirmaciones.keys.toList()..shuffle();
    final diezAfirmacionesKeys = afirmacionesKeys.sublist(0, 10);
    final diezAfirmaciones = <String, bool>{};
    for (final key in diezAfirmacionesKeys) {
      diezAfirmaciones[key] = afirmaciones[key]!;
    }
    return diezAfirmaciones;
  }

  String _modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';

      if (_modulo == 'Matemáticas') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesMAT);
      } else if (_modulo == 'Inglés') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesING);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startCountdown();
    _getModuloFromSharedPrefs();

/*     if (_modulo == 'Matemáticas') {
      diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesMAT);
    } else if (_modulo == 'Inglés') {
      diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesING);
    } else {
      diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmaciones);
    } */

/*     if (_modulo == 'Inglés') {
      setState(() {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesING);
      });
    } */
  }

  void _showResult(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correcto' : 'Incorrecto'),
          content: isCorrect
              ? const Icon(Icons.check, color: Colors.green, size: 60.0)
              : const Icon(Icons.close, color: Colors.red, size: 60.0),
        );
      },
    );
  }

  int tries = 0;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    if (diezAfirmaciones.values.elementAt(_currentAfirmacionIndex)) {
      _verdaderoButtonColor = Colors.green;
    } else {
      _verdaderoButtonColor = Colors.red;
    }

    if (!diezAfirmaciones.values.elementAt(_currentAfirmacionIndex)) {
      _falsoButtonColor = Colors.green;
    } else {
      _falsoButtonColor = Colors.red;
    }
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: null,
      body: Stack(alignment: Alignment.center, children: [
        Column(
          children: [
            const SizedBox(
              height: 80.0,
            ),
            const Text(
              "¿Verdadero o Falso?",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'BubblegumSans',
                fontWeight: FontWeight.bold,
                color: colors_colpaner.claro,
              ),
            ),
/*             const Divider(
              color: colors_colpaner.oscuro,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(
                  '${_currentAfirmacionIndex + 1}/${diezAfirmaciones.length}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'BubblegumSans',
                    fontWeight: FontWeight.bold,
                    color: colors_colpaner.oscuro,
                  ),
                ),
              ),
            ), */
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                scoreBoard1("Intentos", "${tries.toInt()}/10"),
                scoreBoard1("Puntos", "$score/10")
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: colors_colpaner.claro,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    seleccion != null
                        ? seleccion ==
                                diezAfirmaciones.values
                                    .toList()[_currentAfirmacionIndex]
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              )
                            : const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 50,
                              )
                        : const SizedBox(),
                    Text(
                      diezAfirmaciones.keys.elementAt(_currentAfirmacionIndex),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'BubblegumSans',
                        //fontWeight: FontWeight.bold,
                        color: colors_colpaner.oscuro,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (trueButton == false &&
                                  falseButton == true)
                              ? null
                              : () {
                                  if (seleccion != null) {
                                    bool respuesta = diezAfirmaciones.values
                                        .toList()[_currentAfirmacionIndex];
                                    //_showResult(seleccion == respuesta);
                                  }

                                  setState(() {
                                    tries++;
                                    seleccion = true;
                                    trueButton = true;
                                    falseButton = false;

                                    if (diezAfirmaciones.values
                                        .elementAt(_currentAfirmacionIndex)) {
                                      setState(() {
                                        score++;
                                      });
                                      //_showCorrectAnswerDialog();
                                    } else {
                                      //_incrementTries();
                                      //_showIncorrectAnswerDialog();
                                    }

                                    if (tries >= 10) {
                                      _allAfirmacionesShown = true;
                                      gameOver6(score);
                                      // Guardar puntaje de nivel en firestore

                                      _guardarPuntajeNivel6(
                                          score); // Llamar a la función para guardar el puntaje
                                    }
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Verdadero",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color:
                                  (trueButton == false && falseButton == true)
                                      ? Colors.grey
                                      : colors_colpaner.claro,
                            ),
                          ),
                        )),
                    SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (trueButton == true &&
                                    falseButton == false)
                                ? null
                                : () {
                                    if (seleccion != null) {
                                      bool respuesta = diezAfirmaciones.values
                                          .toList()[_currentAfirmacionIndex];
                                      //_showResult(seleccion == respuesta);
                                    }
                                    setState(() {
                                      tries++;
                                      seleccion = false;
                                      falseButton = true;
                                      trueButton = false;

                                      if (!diezAfirmaciones.values
                                          .elementAt(_currentAfirmacionIndex)) {
                                        setState(() {
                                          score++;
                                        });

                                        //_showCorrectAnswerDialog();
                                      } else {
                                        //_incrementTries();
                                        //_showIncorrectAnswerDialog();
                                      }

                                      if (tries >= 10) {
                                        _allAfirmacionesShown = true;
                                        gameOver6(score);
                                        // Guardar puntaje de nivel en firestore

                                        _guardarPuntajeNivel6(
                                            score); // Llamar a la función para guardar el puntaje
                                      }
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text(
                              "Falso",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro),
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            const SizedBox(height: 16),
            seleccion != null
                ? seleccion ==
                            diezAfirmaciones.values
                                .toList()[_currentAfirmacionIndex] ||
                        seleccion !=
                            diezAfirmaciones.values
                                .toList()[_currentAfirmacionIndex]
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                if (seleccion != null) {
                                  bool respuesta = diezAfirmaciones.values
                                      .toList()[_currentAfirmacionIndex];
                                  //_showResult(seleccion == respuesta);
                                }

                                setState(() {
                                  falseButton = false;
                                  trueButton = false;
                                  seleccion = null;
                                  if (_currentAfirmacionIndex <
                                      diezAfirmaciones.length - 1) {
                                    _currentAfirmacionIndex++;
                                  } else {
                                    _currentAfirmacionIndex = 0;
                                  }
                                });
                              },
                              child: const Text(
                                "Siguiente",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),

        //flecha atras
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: ShakeWidgetX(
              child: IconButton(
                icon: Image.asset('assets/flecha_left.png'),
                iconSize: 3,
                onPressed: () {
                  if (tries <= 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Debes terminar el nivel antes de volver"),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 1),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimation,
                                Widget child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.elasticOut);

                              return ScaleTransition(
                                alignment: Alignment.center,
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimattion) {
                              return const world_game();
                            }));
                  }
                },
              ),
            ),
          ),
        ),
        if (_message != "")
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                  child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    _message,
                    style: customTextStyle,
                  ),
                ),
              )),
            ),
          ),
      ]),
    );
  }

  Future<void> gameOver6(int score) async {
    if (_allAfirmacionesShown) {
      DialogHelper.showDialogGameOver(context, score);
    }
  }

  Future<void> _guardarPuntajeNivel6(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido

    //obtiene el modulo del shp
    String modulo = await getModulo();

    if (modulo == 'Matemáticas') {
      //no lo tiene por que escribir en shp porque nunca se escribirá  puntajes a shp, solo se lee de firestore, mas no escribir
      /*  //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntajes_MAT', score); */

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (modulo == 'Inglés') {
      //establece el puntaje obtenido y lo guarda en shp
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('puntaje_ing_6', score);

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
