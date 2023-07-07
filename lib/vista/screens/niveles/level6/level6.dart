import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*LEVEL 6
  True - False Game. User will see one afirmation and two options: true/false
  The are 10 points & 10 tries
*/

class level6 extends StatefulWidget {
  const level6({super.key});

  @override
  State<level6> createState() => _level6State();
}

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
    "El teorema de Pitágoras se aplica únicamente en triángulos equiláteros.":
        false,
    "El número π es irracional y su aproximación decimal más común es 3.1416.":
        true,
    "La función exponencial crece de forma exponencial a medida que x aumenta.":
        true,
    "Un número racional puede ser expresado como una fracción o un decimal finito o periódico.":
        true,
    "El valor absoluto de un número siempre es un número positivo o cero.":
        true,
    "El logaritmo de un número negativo no está definido en los números reales.":
        true,
    "El conjunto de los números naturales incluye al número cero (0).": false,
    "El método de Gauss-Jordan se utiliza para resolver sistemas de ecuaciones lineales.":
        true,
    "El radio de un círculo es la mitad de su diámetro.": true,
    "La mediana es el valor que se encuentra en el centro de un conjunto de datos ordenados.":
        true,
  };

  Map<String, bool> afirmacionesING = {
    "El verbo 'to be' se utiliza para expresar estados y características permanentes.":
        true,
    "El presente simple se utiliza para hablar de acciones que ocurren en el momento actual.":
        false,
    "El adjetivo 'beautiful' se compara en grado superlativo añadiendo el sufijo '-er'.":
        false,
    "El tiempo verbal 'past continuous' se utiliza para expresar acciones que estaban ocurriendo en el pasado de forma continua.":
        true,
    "El 'gerund' es una forma verbal que termina en '-ing' y se utiliza como un sustantivo.":
        true,
    "El condicional tipo 1 se utiliza para expresar situaciones hipotéticas en el presente y sus posibles consecuencias.":
        true,
    "El sustantivo 'child' se pluraliza añadiendo la terminación '-s' al final.":
        false,
    "El adverbio 'carefully' es el comparativo de 'careful' y se utiliza para expresar mayor cuidado.":
        false,
    "El pronombre 'it' se utiliza para referirse a una persona o animal.":
        false,
    "El tiempo verbal 'future perfect' se utiliza para hablar de acciones que se habrán completado en el futuro.":
        true,
  };

  Map<String, bool> afirmacionesLEC = {
    "El propósito principal de un texto informativo es persuadir al lector sobre un punto de vista específico.":
        false,
    "El autor implícito es aquel que está claramente identificado en el texto y expresa su opinión personal.":
        false,
    "La estructura de un texto argumentativo se compone de introducción, desarrollo y conclusión.":
        true,
    "El análisis de las características del lenguaje utilizado en un texto ayuda a comprender su tono y propósito.":
        true,
    "La coherencia se refiere a la relación lógica y fluida entre las ideas y oraciones de un texto.":
        true,
    "La inferencia es una habilidad que consiste en deducir información no explícita a partir de pistas contextuales.":
        true,
    "La tesis de un texto es una afirmación que se presenta al final del mismo para sorprender al lector.":
        false,
    "La función del paratexto es brindar información adicional y contextualizar el contenido principal del texto.":
        true,
    "La comprensión literal se limita a entender únicamente la información explícita en el texto.":
        true,
    "La lectura crítica implica evaluar la validez de argumentos y evidencias presentados en un texto.":
        true,
  };

  Map<String, bool> afirmacionesCIU = {
    "El respeto hacia los demás es una competencia ciudadana que implica reconocer y valorar la dignidad de todas las personas.":
        true,
    "La participación ciudadana se refiere únicamente a votar en elecciones políticas.":
        false,
    "La empatía es una competencia ciudadana que implica ponerse en el lugar del otro y comprender sus sentimientos y perspectivas.":
        true,
    "La responsabilidad ciudadana implica solo cumplir con las leyes y normas establecidas en la sociedad.":
        false,
    "El diálogo constructivo es una competencia ciudadana que fomenta la comunicación respetuosa y el intercambio de ideas para llegar a acuerdos.":
        true,
    "La tolerancia consiste en aceptar y respetar las diferencias individuales, culturales y sociales.":
        true,
    "La corrupción es una práctica aceptable en una sociedad democrática.":
        false,
    "El ejercicio de los derechos y deberes ciudadanos solo es responsabilidad del gobierno.":
        false,
    "La solidaridad es una competencia ciudadana que se basa en la colaboración y el apoyo mutuo entre los miembros de una sociedad.":
        true,
    "La igualdad de género es un principio fundamental de las competencias ciudadanas que busca eliminar la discriminación y garantizar la equidad entre hombres y mujeres.":
        true,
  };

  Map<String, bool> afirmacionesNAT = {
    "La teoría celular establece que la célula es la unidad básica de la vida y que todos los organismos están compuestos por células.":
        true,
    "El ADN es una molécula que almacena la información genética y se encuentra únicamente en las células animales.":
        false,
    "La fotosíntesis es el proceso mediante el cual las plantas convierten la energía solar en energía química para alimentarse.":
        true,
    "La ley de la conservación de la energía establece que la energía no se crea ni se destruye, solo se transforma de una forma a otra.":
        true,
    "La clasificación de los seres vivos se basa únicamente en su apariencia física y características externas.":
        false,
    "El sistema nervioso es responsable de la transmisión de señales y el control de las funciones del cuerpo humano.":
        true,
    "Los ácidos son sustancias que tienen un pH mayor a 7 y suelen tener un sabor amargo.":
        false,
    "La gravedad es una fuerza que atrae a los objetos hacia el centro de la Tierra y es responsable de mantenerlos en órbita alrededor del planeta.":
        true,
    "El ciclo del agua incluye los procesos de evaporación, condensación, precipitación y transpiración.":
        true,
    "La energía nuclear es una fuente de energía renovable que se obtiene a partir de la combustión de combustibles fósiles.":
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

      if (_modulo == 'Razonamiento Cuantitativo') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesMAT);
      } else if (_modulo == 'Inglés') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesING);
      } else if (_modulo == 'Ciencias Naturales') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesNAT);
      } else if (_modulo == 'Competencias Ciudadanas') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesCIU);
      } else if (_modulo == 'Lectura Crítica') {
        diezAfirmaciones = obtenerAfirmacionesAleatorias(afirmacionesLEC);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startCountdown();
    _getModuloFromSharedPrefs();
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
              height: 50.0,
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
            Text(
              "$_modulo",
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'BubblegumSans',
                fontWeight: FontWeight.bold,
                color: colors_colpaner.oscuro,
              ),
            ),
            const Divider(
              color: colors_colpaner.oscuro,
            ),
/*             
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
                          padding: EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors_colpaner.oscuro,
                              ),
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
    LocalStorage localStorage = LocalStorage();

    //obtiene el modulo del shp
    String modulo = await localStorage.getModulo();

    if (_modulo == 'Razonamiento Cuantitativo') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreMat6(score);

      //unlock next level
      localStorage.setMatBtn7Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Inglés') {
      //unlock next level
      localStorage.setIngBtn7Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Lectura Crítica') {
      //unlock next level
      localStorage.setLecBtn7Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Ciencias Naturales') {
      //unlock next level
      localStorage.setNatBtn7Unlock();

      final puntajesRefSoc = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('naturales')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Competencias Ciudadanas') {
      //unlock next level
      localStorage.setCiuBtn7Unlock();

      final puntajesRefCiu = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ciudadanas')
          .collection('nivel6')
          .doc(user!.uid);

      await puntajesRefCiu.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
