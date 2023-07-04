import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';

import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/niveles/level7/utils/level7_game.dart';
import 'package:gamicolpaner/vista/screens/niveles/level7/widget/letter.dart';
import 'package:gamicolpaner/vista/screens/niveles/level7/widget/level3_figure_image.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*NIVEL TIPO AHORCADO
  Este nivel consiste en hacer leer un enunciado y escribir cada letra de forma correcta
  El jugador deberá adivinar el concepto completo.

  El sistema validará la respuesta seleccionada pintando en pantalla cada parte del personaje.

*/
class level7 extends StatefulWidget {
  const level7({Key? key}) : super(key: key);
  @override
  State<level7> createState() => _level7State();
}

class _level7State extends State<level7> {
  String modulo = '';
  String _message = "";
  int _timeLeft = 6;
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "Ñ",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  String afirmacion = "";
  String word = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      modulo = prefs.getString('modulo') ?? '';
      setWordsModulo();
    });
  }

  int countWordSinRepetidos = 0;

  void setWordsModulo() {
    //El siguiente condicional contendrá la palabra clave y afirmación que será la que tendra que adivinar e ingresar el usuario en el juego

    setState(() {
      if (modulo.contains('Lectura Crítica')) {
        afirmacion =
            'Es una figura retórica que consiste en exagerar o amplificar una cualidad o característica de algo o alguien para enfatizar su importancia o impacto.';
        word = "HIPERBOLA".toUpperCase();
      }
      if (modulo.contains('Inglés')) {
        afirmacion =
            'The use of this (plural word) in English provides flexibility and expresses various degrees of possibility, necessity, and ability.';
        word = "MODALS";
      }

      if (modulo.contains('Razonamiento Cuantitativo')) {
        afirmacion =
            'Es un número que no puede expresarse como una fracción exacta y cuyo decimal no termina ni se repite.';
        word = "IRRACIONAL".toUpperCase();
      }

      if (modulo.contains('Ciencias Naturales')) {
        afirmacion =
            'Son los compuestos químicos formados por carbono e hidrógeno, y pueden encontrarse en diversas formas como sólidos, líquidos o gases.';
        word = "HIDROCARBUROS".toUpperCase();
      }

      if (modulo.contains('Competencias Ciudadanas')) {
        afirmacion =
            'Son las habilidades, conocimientos y actitudes necesarias para participar de manera responsable en la sociedad, promoviendo valores democráticos, el respeto a los derechos humanos y la convivencia pacífica.';
        word = "PARTICIPACION".toUpperCase();
      }

      Set<String> uniqueLetters = word.split('').toSet();
      int countWordSinRepetidos = uniqueLetters.length;

      numIntentosMax = countWordSinRepetidos + 6;
    });
  }

  int numIntentosMax = 6;
  int numIntentos = 0;
  bool gameover = false;
  int _start = 60;
  bool _isRunning = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _start--;
      });

      if (_start == 0) {
        //guarda puntaje de nivel en firestore
        _guardarPuntajeNivel7(Game7.succes);

        DialogHelper.showDialogGameOver(context, Game7.succes.toString());

        setState(() {
          _isRunning = false;
          //abre dialogo game over
        });
        _timer.cancel();
      }
    });
  }

  void stopTimer() {
    setState(() {
      _isRunning = false;
      _timer.cancel();
    });
  }

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
          startTimer();
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _message = "";
          });
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getModuloFromSharedPrefs();

    //numero de intentos es el numero de letras sin repetir + 3
//    numIntentosMax = countWordSinRepetidos + 3;

    _startCountdown();
    gameover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          SizedBox(
            //dimension de ancho y alto de pantalla
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "El Ahorcado",
                              style: TextStyle(
                                fontSize: 40.0,
                                fontFamily: 'BubblegumSans',
                                fontWeight: FontWeight.bold,
                                color: colors_colpaner.claro,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: colors_colpaner.oscuro,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    color: colors_colpaner.claro,
                                    Icons.timer,
                                    size: 20,
                                  ),
                                  Text(
                                    '$_start',
                                    style: const TextStyle(
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 15,
                                        color: colors_colpaner.claro),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        modulo,
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreBoard1(
                              "Intentos", "$numIntentos/$numIntentosMax"),
                          scoreBoard1("Puntos", "${Game7.succes}")
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      //texto de afirmación
                      Positioned(
                        top: 10,
                        left: -10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
                          child: Text(
                            afirmacion,
                            style: const TextStyle(
                                color: colors_colpaner.claro,
                                fontSize: 18,
                                fontFamily: 'BubblegumSans'),
                          ),
                        ),
                      ),

                      Center(
                        child: Stack(
                          //corresponde a cada imagen de parte de cuerpo del personaje de ahorcado
                          children: [
                            figureImage(Game7.tries >= 0,
                                "assets/games/level3/hang.png"),
                            figureImage(Game7.tries >= 1,
                                "assets/games/level3/head.png"),
                            figureImage(Game7.tries >= 2,
                                "assets/games/level3/body.png"),
                            figureImage(
                                Game7.tries >= 3, "assets/games/level3/ra.png"),
                            figureImage(
                                Game7.tries >= 4, "assets/games/level3/la.png"),
                            figureImage(
                                Game7.tries >= 5, "assets/games/level3/rl.png"),
                            figureImage(
                                Game7.tries >= 6, "assets/games/level3/ll.png"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: word
                              .split('')
                              .map((e) => letter(
                                  e.toUpperCase(),
                                  !Game7.selectedChar
                                      .contains(e.toUpperCase())))
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 10),

                      //building the Game keyboard
                      SizedBox(
                        width: double.infinity,
                        height: 250.0,
                        child: GridView.count(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          padding: const EdgeInsets.all(8.0),
                          children: alphabets.map((e) {
                            return RawMaterialButton(
                                onPressed: Game7.selectedChar.contains(e)
                                    ? null // Se valida si no se ha seleccionado el botón anterior
                                    : () {
                                        setState(() {
                                          numIntentos++;

                                          Game7.selectedChar.add(e);
                                          print(Game7.selectedChar);
                                          if (!word
                                              .split('')
                                              .contains(e.toUpperCase())) {
                                            Game7.tries++;
                                          }

                                          //si la palabra escrita está en las cajas entonces aumenta numero de exitos
                                          if (word
                                              .split('')
                                              .contains(e.toUpperCase())) {
                                            Game7.succes++;
                                          }

                                          //GAME OVER HIDROCARBUROS

                                          //si falla mas de lo debido
                                          if (numIntentos == numIntentosMax) {
                                            stopTimer();
                                            print(
                                                'SE ALCANZÓ EL NUMERO MAXIMO DE INTENTOS');
                                            //Opcional, enviar como parametro respuesta correcta y mostrar en ese dialogo
                                            DialogHelper.showDialogGameOver(
                                                context,
                                                Game7.succes
                                                    .toString()); //gana 0 puntos si perdió el nivel || SCORE

                                            //guarda puntaje de nivel en firestore
                                            _guardarPuntajeNivel7(Game7.succes);

                                            setState(() {
                                              numIntentos = 0;
                                              gameover = true;
                                              Game7.tries = 0;
                                              Game7.succes = 0;
                                              Game7.selectedChar.clear();
                                            });
                                          }

                                          // y si se logra el llenado de las letras minimas completas entonces
                                          if (Game7.succes == word.length ||
                                              Game7.succes ==
                                                  countWordSinRepetidos) {
                                            stopTimer();
                                            print(
                                                'PALABRA COMPLETADA CORRECTAMENTE');
                                            //guarda puntaje de nivel en firestore
                                            _guardarPuntajeNivel7(Game7.succes);

                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
                                              DialogHelper.showDialogGameOver(
                                                  context,
                                                  Game7.succes.toString());

                                              setState(() {
                                                numIntentos = 0;
                                                gameover = true;
                                                Game7.tries = 0;
                                                Game7.succes = 0;
                                                Game7.selectedChar.clear();
                                              });
                                            });
                                          }
                                        });
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Game7.selectedChar.contains(e)
                                    ? colors_colpaner.base
                                    : colors_colpaner.oscuro,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      //COLOR TEXT BOARD
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BubblegumSans'),
                                )); //color red normal
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
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
                    setState(() {
                      numIntentos = 0;
                      gameover = true;
                      Game7.tries = 0;
                      Game7.succes = 0;
                      Game7.selectedChar.clear();
                    });

                    Navigator.of(context).pushReplacement(
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
                          }),
                    );
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
        ],
      ),
    );
  }

  Future<void> _guardarPuntajeNivel7(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido
    LocalStorage localStorage = LocalStorage();

    //obtiene el modulo del shp
    String _modulo = await localStorage.getModulo();

    if (_modulo == 'Razonamiento Cuantitativo') {
      //no lo tiene por que escribir en shp porque nunca se escribirá  puntajes a shp, solo se lee de firestore, mas no escribir
      /*  //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntajes_MAT', score); */

      //unlock next level
      localStorage.setMatBtn8Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel7')
          .doc(user!.uid);

      //unlock next level
      localStorage.setMatBtn8Unlock();

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Inglés') {
      //establece el puntaje obtenido y lo guarda en shp
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('puntaje_ing_1', score);

      //unlock next level
      localStorage.setIngBtn8Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel7')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Lectura Crítica') {
      //unlock next level
      localStorage.setLecBtn8Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel7')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Ciencias Naturales') {
      //unlock next level
      localStorage.setNatBtn8Unlock();

      final puntajesRefSoc = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('naturales')
          .collection('nivel7')
          .doc(user!.uid);

      await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Competencias Ciudadanas') {
      //unlock next level
      localStorage.setCiuBtn8Unlock();

      final puntajesRefCiu = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ciudadanas')
          .collection('nivel7')
          .doc(user!.uid);

      await puntajesRefCiu.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
