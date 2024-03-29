import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/scoreCards.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class inglessoup extends StatefulWidget {
  const inglessoup({super.key});

  @override
  State<inglessoup> createState() => _inglessoupState();
}

String currentWord = '';
List<String> words = [];

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Fluttertoast.showToast(
        msg: 'Por reglas del juego está prohibido salir de la app.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else if (state == AppLifecycleState.resumed) {
      Fluttertoast.showToast(
        msg: 'Se descontarán puntos en el próximo juego.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}

class _inglessoupState extends State<inglessoup> {
  String _message = "";
  int _timeLeft = 6;

  void _startCountdown() {
    Future.delayed(const Duration(milliseconds: 600), () {
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

  int score = 0;
  int tries = 0;

  Future<int> indexAnterior1() async {
    int valor = await leerindexAnteriorSHP();

    print('IMPRIMIENDO VALOR: $valor');
    return valor;
  }

  void addLetterToCurrentWord(String letter) {
    currentWord += letter;
    print(currentWord);
    //print('indexAnterior CLASE 1: ');
    //print(indexAnterior1());

    if (words.contains(currentWord)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Palabra encontrada!"),
        ),
      );

      setState(() {
        score++;
        currentWord = '';
        guardarindexAnteriorSHP(0);
      });

      //print('indexAnterior desp de enc: $indexAnterior');
    }
  }

  int _start = 120;
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

      if (_start == 0 || score == 5) {
        //guarda puntaje de nivel en firestore
        _guardarPuntajeNivel3(score);

        DialogHelper.showDialogGameOver(context, score.toString());

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

  final AppLifecycleObserver _lifecycleObserver = AppLifecycleObserver();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startCountdown();
    words = ['GRAMMAR', 'VOCABULARY', 'TENSES', 'READING', 'WRITING'];

    WidgetsBinding.instance?.addObserver(_lifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(_lifecycleObserver);
    super.dispose();
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
              //texto pantalla sopa de letras

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
                        //Fluttertoast.showToast(msg: '$numberOfQuestions');
                        if (_start != 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Debes terminar el nivel antes de volver"),
                            ),
                          );
                        } else {
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

              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Sopa de letras',
                        style: TextStyle(
                          fontSize: 48.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro,
                        ),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Inglés',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'BubblegumSans',
                          color: colors_colpaner.oscuro,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                          color: colors_colpaner.claro,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          children: [
                            Column(children: [
                              const Icon(
                                color: colors_colpaner.oscuro,
                                Icons.timer,
                                size: 30,
                              ),
                              Text(
                                '$_start',
                                style: const TextStyle(
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20,
                                    color: colors_colpaner.oscuro),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      scoreBoard1("Puntos", "$score/5"),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        words.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro,
                        ),
                      ),
                    ),
                  ),
                  ExpandedSoup(),
                  //ExpandedSop1(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            currentWord,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                              color: colors_colpaner.claro,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(80, 0, 30, 0),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 29, 16),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        currentWord = '';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: colors_colpaner.claro,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget ExpandedSoup() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Center(
            child: GridView.count(
          crossAxisCount: 9,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          children: [
            CustomTextButton(
              text: 'W',
              indexActual: 1,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('W');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 2,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 3,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 4,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 5,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'G',
              indexActual: 6,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('G');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 7,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'X',
              indexActual: 8,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('X');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'V',
              indexActual: 9,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('V');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            //
            CustomTextButton(
              text: 'J',
              indexActual: 10,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('J');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'R',
              indexActual: 11,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 12,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 13,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'B',
              indexActual: 14,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('B');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 15,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'C',
              indexActual: 16,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'O',
              indexActual: 17,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'V',
              indexActual: 18,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('V');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            //
            CustomTextButton(
              text: 'A',
              indexActual: 19,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 20,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 21,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 22,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 23,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 24,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'B',
              indexActual: 25,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('B');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 26,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'O',
              indexActual: 27,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'A',
              indexActual: 28,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'Z',
              indexActual: 29,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('Z');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'O',
              indexActual: 30,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 31,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 32,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 33,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 33,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 34,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'C',
              indexActual: 35,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'R',
              indexActual: 36,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 37,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 38,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 39,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 40,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'B',
              indexActual: 41,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('B');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 42,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 43,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 44,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'R',
              indexActual: 45,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'D',
              indexActual: 46,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('D');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'C',
              indexActual: 47,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'W',
              indexActual: 48,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('W');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'G',
              indexActual: 49,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('G');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 50,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 51,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'X',
              indexActual: 52,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('X');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'B',
              indexActual: 53,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('B');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'A',
              indexActual: 54,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 55,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 56,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 57,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 58,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'H',
              indexActual: 59,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('H');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'G',
              indexActual: 60,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('G');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 61,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'U',
              indexActual: 62,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('U');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'M',
              indexActual: 63,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('M');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 64,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'U',
              indexActual: 65,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('U');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'X',
              indexActual: 66,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('X');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 67,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 68,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 69,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'H',
              indexActual: 70,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('H');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 71,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'M',
              indexActual: 72,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('M');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 73,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 74,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 75,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'D',
              indexActual: 76,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('D');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 77,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 78,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'J',
              indexActual: 79,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('J');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 80,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'A',
              indexActual: 81,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 82,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 83,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 84,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'A',
              indexActual: 85,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('A');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'L',
              indexActual: 86,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('L');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 87,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'J',
              indexActual: 88,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('J');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'R',
              indexActual: 89,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'R',
              indexActual: 90,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'C',
              indexActual: 91,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'O',
              indexActual: 92,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'H',
              indexActual: 93,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('H');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 94,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 95,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 96,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'O',
              indexActual: 97,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'Y',
              indexActual: 98,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('Y');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //
            CustomTextButton(
              text: 'G',
              indexActual: 99,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('G');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'C',
              indexActual: 100,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('C');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 101,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 102,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'R',
              indexActual: 103,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('R');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 104,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'F',
              indexActual: 105,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('F');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 106,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'I',
              indexActual: 107,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('I');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            //
            //

            CustomTextButton(
              text: 'O',
              indexActual: 108,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('O');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 109,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 110,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'S',
              indexActual: 111,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('S');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'N',
              indexActual: 112,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('N');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 113,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 114,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'E',
              indexActual: 115,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('E');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
            CustomTextButton(
              text: 'T',
              indexActual: 116,
              onPressed: () {
                setState(() {
                  addLetterToCurrentWord('T');
                }); //COPIAR Y PEGAR EN REEMPLAZAR PARA CADA LETRA
              },
            ),
          ],
        )),
      ),
    );
  }

  Future<void> _guardarPuntajeNivel3(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido

    LocalStorage localStorage = LocalStorage();

    //save score in shared preferente to save resources at firebase
    localStorage.setScoreIng3(score);

    //unlock next level
    localStorage.setIngBtn4Unlock();

    //guarda puntaje en firestore
    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel3')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }
}

// Guardar un indexAnteriorSHP en SharedPreferences
Future<void> guardarindexAnteriorSHP(int valor) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('indexAnteriorSHP', valor);
}

// Leer un indexAnteriorSHP de SharedPreferences
Future<int> leerindexAnteriorSHP() async {
  final prefs = await SharedPreferences.getInstance();
  int valor = prefs.getInt('indexAnteriorSHP') ?? 0;
  return valor;
}

class CustomTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? pressedColor;
  late final int? indexActual;

  CustomTextButton(
      {required this.text,
      required this.onPressed,
      this.pressedColor,
      this.indexActual});

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  bool _isPressed = false;
  int indexAnterior = 0;

  late int izquierdoBtn = widget.indexActual! - 1;
  late int derechoBtn = widget.indexActual! + 1;
  late int arribaBtn = widget.indexActual! - 9;
  late int abajoBtn = widget.indexActual! + 1;

  late int diagIzqUp = widget.indexActual! - 10;
  late int diagIzqDown = widget.indexActual! + 8;
  late int diagDerUp = widget.indexActual! - 8;
  late int diagDerDown = widget.indexActual! + 10;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          _isPressed ? colors_colpaner.claro : colors_colpaner.oscuro,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 10.0,
            fontFamily: 'BubblegumSans',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      onPressed: () async {
        indexAnterior = await leerindexAnteriorSHP();
        setState(() {
          _isPressed = true;
          print('index actual: ${widget.indexActual}');
          print('index anterior: $indexAnterior');
        });
        if (widget.indexActual! == indexAnterior - 1 ||
            widget.indexActual! == indexAnterior + 1 ||
            widget.indexActual! == indexAnterior - 9 ||
            widget.indexActual! == indexAnterior + 9 ||
            widget.indexActual! == indexAnterior - 8 ||
            widget.indexActual! == indexAnterior + 10 ||
            widget.indexActual! == indexAnterior - 10 ||
            widget.indexActual! == indexAnterior + 8) {
          //cuando toca boton izquierdo widget.indexActual! == indexAnterior -1
          //cuando toca boton derecho widget.indexActual! == indexAnterior +1
          //cuando toca boton arriba widget.indexActual! == indexAnterior -9
          //cuando toca boton abajo widget.indexActual! == indexAnterior +9
          //cuando toca boton diagonal derecho arriba widget.indexActual! == indexAnterior -8
          //cuando toca boton diagonal derecho abajo widget.indexActual! == indexAnterior +10
          //cuando toca boton diagonal izquiero arriba widget.indexActual! == indexAnterior -10
          //cuando toca boton diagonal izquierdo abajo widget.indexActual! == indexAnterior +8

          setState(() {
            guardarindexAnteriorSHP(widget.indexActual!);
          });
          widget.onPressed();
        } else {
          //Entra aqui cuando es cero o primera vez boton de cada palabra
          print('indexAnterior CLASE 2: $indexAnterior');
          if (indexAnterior == 0 || currentWord == '') {
            setState(() {
              guardarindexAnteriorSHP(widget.indexActual!);
            });
            widget.onPressed();
          } else {
            //cuando viola las reglas de adyascentes menos el mismo boton en si mismo
            if (indexAnterior != widget.indexActual) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("¡Solo letras adyacentes!"),
                ),
              );
              _isPressed = false;
              setState(() {
                currentWord = '';
                widget.indexActual = indexAnterior;
                guardarindexAnteriorSHP(widget.indexActual!);
              });
            }
          }
        }
      },
      child: Text(
        widget.text,
        style: TextStyle(
            color: _isPressed ? colors_colpaner.base : colors_colpaner.claro,
            fontSize: 15),
      ),
    );
  }
}
