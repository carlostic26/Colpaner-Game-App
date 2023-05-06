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

/*NIVEL TIPO GAMIDROP
  Este nivel consiste en leer y arrastrar un concepto a su enunciado correspondiente.
  El jugador deberá situar correctamente cada elemento para ganar puntos.
  El sistema validará la respuesta seleccionada aumentando el puntaje iterativo.
*/

class level4 extends StatefulWidget {
  const level4({Key? key}) : super(key: key);

  @override
  State<level4> createState() => _level4State();
}

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 24,
  color: Colors.white,
);

class _level4State extends State<level4> {
  String modul = '';

//recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      modul = prefs.getString('modulo') ?? '';

      print('MODULO EN LEVEL 4 ES: $modul');
    });

    if (modul == 'Matemáticas') {
      final List<MapEntry<String, String>> choicesList = choicesMAT.entries
          .map(
              (entry) => MapEntry(entry.key.toString(), entry.value.toString()))
          .toList();

      final Random random = Random();
      sixChoices = Map.fromEntries(List.generate(
        7,
        (_) => choicesList[random.nextInt(choicesList.length)],
      ));
    }

    if (modul == 'Inglés') {
      final List<MapEntry<String, String>> choicesList = choicesING.entries
          .map(
              (entry) => MapEntry(entry.key.toString(), entry.value.toString()))
          .toList();

      final Random random = Random();
      sixChoices = Map.fromEntries(List.generate(
        7,
        (_) => choicesList[random.nextInt(choicesList.length)],
      ));
    }
  }

  final Map<String, bool> score = {};

  final Map choicesMAT = {
    'GET': 'realiza una petición a un recurso específico',
    'POST': 'puede enviar datos al servidor por medio del cuerpo (body)',
    'PUT': 'puede ser ejecutado varias veces y tiene el mismo efecto',
    'DELETE': 'permite eliminar un recurso específico',
    'PATCH':
        'se emplea para modificaciones parciales de un recurso en particular',
    'HEAD': ' no retorna ningún contenido HTTP Response',
    'GETU': 'realiza en una petición a un recurso específico',
    'POSTE': 'puede r nenviar datos al servidor por medio del cuerpo (body)',
    'PUTA': 'puedevxfb ser ejecutado dvvarias veces y tiene el mismo efecto',
    'DELETEWE': ' permite vds eliminar sdvun  drecurso específico',
  };

  final Map choicesING = {
    'GET': 'englisg realiza una petición a un recurso específico',
    'POST': 'englisgpuede enviar datos al servidor por medio del cuerpo (body)',
    'PUT': 'englisgpuede ser ejecutado varias veces y tiene el mismo efecto',
    'DELETE': 'englisgpermite eliminar un recurso específico',
    'PATCH': 'englisgse emplea para modificacioneticular',
    'HEAD': 'englisg no retorna ningún contenido HTTP Response',
    'GETU': 'englisg realiza en una petición a un recurso específico',
    'POSTE':
        'englisg puede r nenviar datos al servidor por medio del cuerpo (body)',
    'PUTA':
        'englisg puedevxfb ser ejecutado dvvarias veces y tiene el mismo efecto',
    'DELETEWE': 'englisg permite vds eliminar sdvun  drecurso específico',
  };

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

  late Map<String, String> sixChoices = {};

  @override
  void initState() {
    super.initState();

    _getModuloFromSharedPrefs();
    _startCountdown();
  }

  int seed = 0;

  int intentos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //divider
          Positioned(
            top: -470,
            left: 5,
            right: 5,
            bottom: 100,
            child: Container(
              child: const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
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
                  },
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                height: 82.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    scoreBoard1(
                        "Intentos", "$intentos/${sixChoices.length + 3}"),
                    scoreBoard1("Puntos", "${score.length}")
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(1, 120, 1, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: sixChoices.keys.map((conceptoAfirmacion) {
                      return Draggable<String>(
                        data: conceptoAfirmacion,
                        feedback: ConceptoAfirmacion(
                          conceptoAfirmacion: conceptoAfirmacion,
                        ),
                        childWhenDragging:
                            const ConceptoAfirmacion(conceptoAfirmacion: '🧐'),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            //CONCEPT INSIDE CARD LEFT
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            color: colors_colpaner.oscuro,
                            child: ConceptoAfirmacion(
                                //if concept is correct at draw, then show check emoti in left cards
                                conceptoAfirmacion:
                                    score[conceptoAfirmacion] == true
                                        ? '✅'
                                        : conceptoAfirmacion),
                          ),
                        ),
                      );
                    }).toList()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sixChoices.keys
                      .map((conceptoAfirmacion) =>
                          _buildDragTarget(conceptoAfirmacion))
                      .toList()
                    ..shuffle(Random(seed)),
                ),
              ],
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
        ],
      ),
    );
  }

  Widget _buildDragTarget(conceptoAfirmacion) {
    return DragTarget<String>(
        builder: (BuildContext context, List<String?> incoming, List rejected) {
          if (score[conceptoAfirmacion] == true) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.green,
                alignment: Alignment.center,
                height: 80,
                width: 200,
                child: const Text(
                  'Correcto!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'BubblegumSans'),
                ),
              ),
            );
          } else {
            //text cards answers
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                color: colors_colpaner.claro,
                height: 80,
                width: 200,
                child: Text(
                  sixChoices[conceptoAfirmacion]!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'BubblegumSans'),
                ),
              ),
            );
          }
        },
        onWillAccept: (data) => data == conceptoAfirmacion,
        onAccept: (data) {
          setState(() {
            score[conceptoAfirmacion] = true;
            intentos++;
            //game over, si el usuario completo las 5 palabras, se genera su score y se cierra el nivel
            if (score.length == sixChoices.length ||
                intentos >= sixChoices.length + 3) {
              DialogHelper.showDialogGameOver(context, score.length);
              _guardarPuntajeNivel4(score.length);
            }
          });
        },
        onLeave: (data) {
          setState(() {
            intentos++; // Incrementa la variable "intentosRealizados" al realizar un intento
          });
//game over, si el usuario completo las 5 palabras o si se acaban los intentos
          if (score.length >= sixChoices.length ||
              intentos >= sixChoices.length + 3) {
            DialogHelper.showDialogGameOver(context, score.length);
            _guardarPuntajeNivel4(score.length);
          }
        });
  }
}

Future<void> _guardarPuntajeNivel4(int score) async {
  final user = FirebaseAuth.instance.currentUser;
  final puntaje = score; // Puntaje obtenido

  //obtiene el modulo del shp
  String _modulo = await getModulo();

  if (_modulo == 'Matemáticas') {
    //no lo tiene por que escribir en shp porque nunca se escribirá  puntajes a shp, solo se lee de firestore, mas no escribir
    /*  //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntajes_MAT', score); */

    final puntajesRefMat = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel4')
        .doc(user!.uid);

    await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Inglés') {
    //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntaje_ing_4', score);

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel4')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }
}

class ConceptoAfirmacion extends StatelessWidget {
  const ConceptoAfirmacion({Key? key, required this.conceptoAfirmacion})
      : super(key: key);

  final String conceptoAfirmacion;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              conceptoAfirmacion,
              style: const TextStyle(
                  //color text left csrds
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'BubblegumSans'),
            ),
          )),
    );
  }
}
