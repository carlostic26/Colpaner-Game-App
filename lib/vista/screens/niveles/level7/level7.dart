import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      setState(() {
        countWordSinRepetidos = uniqueLetters.length;
      });

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
    return WillPopScope(
        onWillPop: () async {
          if (_start != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Debes terminar el nivel antes de volver"),
              ),
            );
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: colors_colpaner.base,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.99,
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.040),
                      const Center(
                        child: Text(
                          "El Ahorcado",
                          style: TextStyle(
                            fontSize: 40.0, // Reducir el tamaño de la fuente
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.bold,
                            color: colors_colpaner.claro,
                          ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          scoreBoard1(
                            "Puntos",
                            "${Game7.succes}/$countWordSinRepetidos",
                          ),
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: colors_colpaner.claro,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  color: colors_colpaner.oscuro,
                                  Icons.timer,
                                  size: 30,
                                ),
                                Text(
                                  '$_start',
                                  style: const TextStyle(
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 15,
                                    color: colors_colpaner.oscuro,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
                        child: Text(
                          afirmacion,
                          style: const TextStyle(
                            color: colors_colpaner.claro,
                            fontSize: 18,
                            fontFamily: 'BubblegumSans',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.20, // Reducir la altura del área de la figura del ahorcado
                        child: Center(
                          child: Stack(
                            children: [
                              figureImage(Game7.tries >= 0,
                                  "assets/games/level3/hang.png"),
                              figureImage(Game7.tries >= 1,
                                  "assets/games/level3/head.png"),
                              figureImage(Game7.tries >= 2,
                                  "assets/games/level3/body.png"),
                              figureImage(Game7.tries >= 3,
                                  "assets/games/level3/ra.png"),
                              figureImage(Game7.tries >= 4,
                                  "assets/games/level3/la.png"),
                              figureImage(Game7.tries >= 5,
                                  "assets/games/level3/rl.png"),
                              figureImage(Game7.tries >= 6,
                                  "assets/games/level3/ll.png"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: word
                              .split('')
                              .map((e) => letter(
                                    e.toUpperCase(),
                                    !Game7.selectedChar
                                        .contains(e.toUpperCase()),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Wrap(
                                // Cambiar a Wrap en lugar de GridView
                                alignment: WrapAlignment.center,
                                spacing: 3.0,
                                runSpacing: 5.0,
                                children: alphabets.map((e) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.width *
                                        0.15, // Definir un ancho fijo para el contenedor
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 1.0),
                                    child: RawMaterialButton(
                                      onPressed: Game7.selectedChar.contains(e)
                                          ? null
                                          : () {
                                              setState(() {
                                                numIntentos++;
                                                Game7.selectedChar.add(e);
                                                print(Game7.selectedChar);
                                                if (!word.split('').contains(
                                                    e.toUpperCase())) {
                                                  setState(() {
                                                    Game7.tries++;
                                                    Game7.fails++;

/*                                                 Fluttertoast.showToast(
                                                  msg: " FAILS: ${Game7.fails}",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                ); */

                                                    if (Game7.fails >= 6) {
                                                      stopTimer();
                                                      print(
                                                          'SE ALCANZÓ EL NUMERO MAXIMO DE INTENTOS');
                                                      _guardarPuntajeNivel7(
                                                          Game7.succes);
                                                      DialogHelper
                                                          .showDialogGameOver(
                                                              context,
                                                              Game7.succes
                                                                  .toString());
                                                      setState(() {
                                                        numIntentos = 0;
                                                        gameover = true;
                                                        Game7.tries = 0;
                                                        Game7.fails = 0;
                                                        Game7.succes = 0;
                                                        Game7.selectedChar
                                                            .clear();
                                                      });
                                                    }
                                                  });
                                                }
                                                if (word.split('').contains(
                                                    e.toUpperCase())) {
                                                  Game7.succes++;
                                                }
                                                if (numIntentos ==
                                                    numIntentosMax) {
                                                  stopTimer();
                                                  print(
                                                      'SE ALCANZÓ EL NUMERO MAXIMO DE INTENTOS');
                                                  _guardarPuntajeNivel7(
                                                      Game7.succes);
                                                  DialogHelper
                                                      .showDialogGameOver(
                                                          context,
                                                          Game7.succes
                                                              .toString());
                                                  setState(() {
                                                    numIntentos = 0;
                                                    gameover = true;
                                                    Game7.tries = 0;
                                                    Game7.succes = 0;
                                                    Game7.selectedChar.clear();
                                                  });
                                                }
                                                if (Game7.succes ==
                                                        word.length ||
                                                    Game7.succes ==
                                                        countWordSinRepetidos) {
                                                  stopTimer();
                                                  print(
                                                      'PALABRA COMPLETADA CORRECTAMENTE');
                                                  _guardarPuntajeNivel7(
                                                      Game7.succes);
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    DialogHelper
                                                        .showDialogGameOver(
                                                            context,
                                                            Game7.succes
                                                                .toString());
                                                    setState(() {
                                                      numIntentos = 0;
                                                      gameover = true;
                                                      Game7.tries = 0;
                                                      Game7.succes = 0;
                                                      Game7.selectedChar
                                                          .clear();
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      fillColor: Game7.selectedChar.contains(e)
                                          ? colors_colpaner.base
                                          : colors_colpaner.oscuro,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BubblegumSans',
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
                        //Fluttertoast.showToast(msg: '$_questionNumber');
                        if (_start != 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Debes terminar el nivel antes de volver"),
                            ),
                          );
                        } else {
                          setState(() {
                            numIntentos = 0;
                            gameover = true;
                            Game7.tries = 0;
                            Game7.succes = 0;
                            Game7.selectedChar.clear();
                          });
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(seconds: 1),
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secAnimation,
                                      Widget child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.elasticOut);

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
                  duration: const Duration(milliseconds: 300),
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
        ));
  }

  Future<void> _guardarPuntajeNivel7(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido
    LocalStorage localStorage = LocalStorage();

    //obtiene el modulo del shp
    String _modulo = await localStorage.getModulo();

    if (_modulo == 'Razonamiento Cuantitativo') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreMat7(score);

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
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreIng7(score);

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
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreLec7(score);

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
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreNat7(score);

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
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreCiu7(score);

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
