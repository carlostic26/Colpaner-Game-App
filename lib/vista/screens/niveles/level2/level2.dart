import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/level2_logic.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*NIVEL TIPO GAMICARD
  Este nivel consiste en hacer coincidir dos tarjetas iguales
  El jugador deberá seleccionar las tarjetas disponibles
  El sistema validará la respuesta seleccionada a traves de puntajes. Existe un límite de intetos.
*/

class level2 extends StatefulWidget {
  const level2({Key? key}) : super(key: key);

  @override
  State<level2> createState() => _level2State();
}

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 24,
  color: Colors.white,
);

class _level2State extends State<level2> {
  final GameCards _gameCards = GameCards();

  String _modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  final Map<int, String> _countdownMessages = {
    4: "Comenzamos en",
    3: "3...",
    2: "2...",
    1: "1...",
  };

  String _message = "";
  int _timeLeft = 6;

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
          _message = _countdownMessages[_timeLeft] ?? "¿Preparado?";
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

  double tries = 0;
  int valTries = 0;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _gameCards.initGame();

    _getModuloFromSharedPrefs();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_heigth = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: colors_colpaner.base,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screen_heigth * 0.1,
                    ),
                    const Center(
                      child: Text(
                        "Memory Cards",
                        style: TextStyle(
                          fontSize: 45.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screen_heigth * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        scoreBoard1("Intentos", "${tries.toInt()}/12"),
                        scoreBoard1("Puntos", "$score/6")
                      ],
                    ),
                    SizedBox(
                      height: screen_heigth * 0.75,
                      width: screen_width,
                      child: GridView.builder(
                          itemCount: _gameCards.gameImg!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          itemBuilder: (context, index) {
                            List<String> cards_List;
                            if (_modulo == 'Razonamiento Cuantitativo') {
                              cards_List = _gameCards.cards_list_mat;
                            } else if (_modulo == 'Lectura Crítica') {
                              cards_List = _gameCards.cards_list_lec;
                            } else if (_modulo == 'Inglés') {
                              cards_List = _gameCards.cards_list_ing;
                            } else if (_modulo == 'Ciencias Naturales') {
                              cards_List = _gameCards.cards_list_nat;
                            } else if (_modulo == 'Competencias Ciudadanas') {
                              cards_List = _gameCards.cards_list_comp;
                            } else {
                              //si no existe la lista de mat sera la predeterminada
                              cards_List = _gameCards.cards_list_mat;
                            }
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    //casteando el valor de cada intento a solo 1 punto por cada 2 movimientos
                                    valTries++;
                                    tries = (valTries / 2);

                                    //si el usuario hace mas de 12 intentos, gameover
                                    if (tries >= 12) {
                                      DialogHelper.showDialogGameOver(
                                          context, score);
                                      _guardarPuntajeNivel2(score);
                                    }

                                    _gameCards.gameImg![index] =
                                        cards_List[index];
                                    _gameCards.matchCheck
                                        .add({index: cards_List[index]});
                                  });
                                  if (_gameCards.matchCheck.length == 2) {
                                    if (_gameCards.matchCheck[0].values.first ==
                                        _gameCards.matchCheck[1].values.first) {
                                      print("true");
                                      score += 1;
                                      _gameCards.matchCheck.clear();

                                      //si el usuario completa los 6 matches se muestra dialogo de game over
                                      if (score >= 6) {
                                        //enviamos score al DialogHelper que conecta a la clase ShowDialogGameOver1
                                        DialogHelper.showDialogGameOver(
                                            context, score);

                                        //guarda puntaje de nivel en firestore
                                        _guardarPuntajeNivel2(score);
                                      }
                                    }
                                    Future.delayed(
                                        const Duration(milliseconds: 1200), () {
                                      setState(() {
                                        _gameCards.gameImg![_gameCards
                                            .matchCheck[0]
                                            .keys
                                            .first] = _gameCards.hiddenCardpath;
                                        _gameCards.gameImg![_gameCards
                                            .matchCheck[1]
                                            .keys
                                            .first] = _gameCards.hiddenCardpath;
                                        _gameCards.matchCheck.clear();
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: ConditionalSwitch.single(
                                      context: context,
                                      valueBuilder: (BuildContext context) =>
                                          _gameCards.gameImg![index],
                                      caseBuilders: {
                                        // Mostrar imagen para la cara oculta
                                        _gameCards.hiddenCardpath:
                                            (BuildContext context) =>
                                                CachedNetworkImage(
                                                    imageUrl: _gameCards
                                                        .hiddenCardpath),
                                      },
                                      fallbackBuilder: (BuildContext context) =>
                                          Text(
                                        _gameCards.gameImg![index],
                                        style: const TextStyle(
                                          fontSize: 9.0,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                    )
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
        ),
      ],
    );
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation,
          Widget child,
        ) {
          animation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          );

          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimattion,
        ) {
          return const world_game();
        },
      ),
    );
  }

  Future<void> _guardarPuntajeNivel2(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido

    //obtiene el modulo del shp
    String _modulo = await getModulo();

    if (_modulo == 'Lectura Crítica') {
      //guarda puntaje en firestore
      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel2')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Competencias Ciudadanas') {
      //guarda puntaje en firestore
      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('competencias')
          .collection('nivel2')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Comunicación Escrita') {
      //guarda puntaje en firestore
      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('comunicacion')
          .collection('nivel2')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Razonamiento Cuantitativo') {
      //guarda puntaje en firestore
      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel2')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Inglés') {
      //guarda puntaje en firestore
      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel2')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
