import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giff_dialog/giff_dialog.dart';

class level8 extends StatefulWidget {
  const level8({super.key});

  @override
  State<level8> createState() => _level8State();
}

SharedPreferences? _prefs;

class _level8State extends State<level8> {
  String _message = "";
  int _timeLeft = 6;
  bool gameover = false;

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

  final selected = BehaviorSubject<int>();
  String preguntaAzar = 'Pregunta!';

  List<String> itemsRoulette = [];
  List<bool> _isSelected = [];

//se inicializa la lista de preguntas
  List<String> temaPregunta = [
    'mat1',
    'mat2',
    'mat3',
    'mat4',
    'mat2',
    'mat3',
    'mat4',
    'mat3',
    'mat4',
    'mat4'
  ];

  List<String> temaPreguntaMat = [
    'Álgebra',
    'Geometría',
    'Trigonometría',
    'Cálculo',
    'Estadística',
    'Probabilidad',
    'Funciones',
    'Números y operaciones',
    'Geometría analítica',
    'Ecuaciones y desigualdades'
  ];

  List<String> temaPreguntaIng = [
    'Verbo To-Be',
    'Verbos auxiliares',
    'Pasado simple',
    'Futuro continuo',
    'Presente perfecto',
    'Vocabulario y sustantivos',
    'Verbos regulares e irregulares',
    'Pronombres y posesivos',
    'Comparativos y superlativos',
    'Condicional (if clauses)'
  ];

  List<String> temaPreguntaLec = [
    'Comprensión de lectura',
    'Análisis de texto',
    'Inferencias y conclusiones',
    'Interpretación de información',
    'Identificación de argumentos',
    'Evaluación de la coherencia y cohesión textual',
    'Relaciones lógicas en un texto',
    'Elementos retóricos y persuasivos',
    'Estilo y tono del autor',
    'Comprensión de vocabulario en contexto'
  ];

  List<String> temaPreguntaNat = [
    'Biología celular',
    'Genética y herencia',
    'Estructura y función de los organismos',
    'Ecología y medio ambiente',
    'Reproducción humana y sexualidad',
    'Sistema nervioso y endocrino',
    'Química básica',
    'Reacciones químicas',
    'Fuerzas y movimientos',
    'Óptica y ondas'
  ];

  List<String> temaPreguntaSoc = [
    'Historia de Colombia',
    'Geografía política',
    'Derechos humanos',
    'Sistemas políticos y democracia',
    'Economía y desarrollo',
    'Globalización',
    'Cultura y diversidad',
    'Conflicto armado y paz',
    'Participación ciudadana',
    'Medio ambiente y sostenibilidad'
  ];

  String _modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });

    if (_modulo == 'Razonamiento Cuantitativo') {
      setState(() {
        temaPregunta = temaPreguntaMat;
      });
    }

    if (_modulo.contains('Lectura Crítica')) {
      setState(() {
        temaPregunta = temaPreguntaLec;
      });
    }
    if (_modulo.contains('Inglés')) {
      setState(() {
        temaPregunta = temaPreguntaIng;
      });
    }
    if (_modulo.contains('Ciencias Naturales')) {
      setState(() {
        temaPregunta = temaPreguntaNat;
      });
    }
    if (_modulo.contains('Competencias Ciudadanas')) {
      setState(() {
        temaPregunta = temaPreguntaSoc;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startCountdown();

    print('entrando a inistate');
    _getModuloFromSharedPrefs();
    _isSelected = List.filled(8, false);
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
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

          Column(
            children: [
              const SizedBox(height: 50),
              //texto roulette
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Roulette",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro,
                        ),
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
                    const SizedBox(
                      height: 10.0,
                    ),
                  ]),

              const SizedBox(height: 50),

              //contenedor de ruleta
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.99,
                height: MediaQuery.of(context).size.height * 0.50,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 7,
                        color: colors_colpaner.claro,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: colors_colpaner.oscuro,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: FortuneWheel(
                        styleStrategy: const UniformStyleStrategy(
                          borderColor: colors_colpaner.oscuro,
                          color: colors_colpaner.base,
                          borderWidth: 4,
                        ),
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          for (int i = 0;
                              i < temaPregunta.length;
                              i++) ...<FortuneItem>{
                            FortuneItem(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: i % 2 == 0
                                          ? colors_colpaner.base
                                          : colors_colpaner.claro,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      temaPregunta[i],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                        ],
                        onAnimationEnd: () {
                          setState(() {
                            preguntaAzar = temaPregunta[selected.value];
                          });
                          showItemDialog(preguntaAzar);

                          //solo por intentar salir al tablero y explicar con sus palabras, ya tiene 5 puntos
                          _guardarPuntajeNivel8(5);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              GestureDetector(
                onTap: () {
                  setState(() {
                    //gira la ruleta y cae en una franja a
                    selected.add(Fortune.randomInt(0, temaPregunta.length));
                  });
                },
                //boton girar
                child: Container(
                  decoration: BoxDecoration(
                    color: colors_colpaner.claro,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width: 130,
                  child: const Center(
                    child: Text(
                      "Girar",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'BubblegumSans',
                          color: colors_colpaner.oscuro),
                    ),
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
    );
  }

  void showItemDialog(String item) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              title: Text(
                '¡$item!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: const Text(
                'Define el concepto con tus palabras. No tardes más de 10 segundos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            colors_colpaner.oscuro,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const world_game()));
                        },
                        child: const Text(
                          'Finalizar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }

  Future<void> _guardarPuntajeNivel8(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido
    LocalStorage localStorage = LocalStorage();

    //obtiene el modulo del shp
    String _modulo = await localStorage.getModulo();

    if (_modulo == 'Razonamiento Cuantitativo') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreMat8(score);

      //unlock next level
      localStorage.setMatBtn9Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel8')
          .doc(user!.uid);

      //unlock next level
      localStorage.setMatBtn9Unlock();

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Inglés') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreIng8(score);

      //unlock next level
      localStorage.setIngBtn9Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel8')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Lectura Crítica') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreLec8(score);

      //unlock next level
      localStorage.setLecBtn9Unlock();
      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel8')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Ciencias Naturales') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreNat8(score);

      //unlock next level
      localStorage.setNatBtn9Unlock();
      final puntajesRefSoc = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('naturales')
          .collection('nivel8')
          .doc(user!.uid);

      await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Competencias Ciudadanas') {
      //unlock next level
      localStorage.setMatBtn9Unlock();

      final puntajesRefCiu = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ciudadanas')
          .collection('nivel8')
          .doc(user!.uid);

      await puntajesRefCiu.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
