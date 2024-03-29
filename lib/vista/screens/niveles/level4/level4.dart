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

class _level4State extends State<level4> {
  String modul = '';

//recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<MapEntry<String, String>> choicesList = [];

    setState(() {
      modul = prefs.getString('modulo') ?? '';

      print('MODULO EN LEVEL 4 ES: $modul');
    });

    final Random random = Random();

    switch (modul) {
      case 'Razonamiento Cuantitativo':
        choicesList = choicesMAT.entries
            .map((entry) =>
                MapEntry(entry.key.toString(), entry.value.toString()))
            .toList();

        choicesList.shuffle(random);

        sixChoices = Map.fromEntries(choicesList.sublist(0, 5));
        break;

      case 'Inglés':
        choicesList = choicesING.entries
            .map((entry) =>
                MapEntry(entry.key.toString(), entry.value.toString()))
            .toList();

        choicesList.shuffle(random);

        sixChoices = Map.fromEntries(choicesList.sublist(0, 5));
        break;

      case 'Lectura Crítica':
        choicesList = choicesLEC.entries
            .map((entry) =>
                MapEntry(entry.key.toString(), entry.value.toString()))
            .toList();

        choicesList.shuffle(random);

        sixChoices = Map.fromEntries(choicesList.sublist(0, 5));
        break;

      case 'Ciencias Naturales':
        choicesList = choicesNAT.entries
            .map((entry) =>
                MapEntry(entry.key.toString(), entry.value.toString()))
            .toList();

        choicesList.shuffle(random);

        sixChoices = Map.fromEntries(choicesList.sublist(0, 5));
        break;

      case 'Competencias Ciudadanas':
        choicesList = choicesCIU.entries
            .map((entry) =>
                MapEntry(entry.key.toString(), entry.value.toString()))
            .toList();

        choicesList.shuffle(random);

        sixChoices = Map.fromEntries(choicesList.sublist(0, 5));
        break;

      default:
        // Código por defecto si el valor de 'modulo' no coincide con ningún caso
        break;
    }
  }

  final Map<String, bool> score = {};

  final Map<String, String> choicesMAT = {
    'Álgebra lineal':
        'Estudio de vectores, matrices y sistemas de ecuaciones lineales',
    'Cálculo diferencial':
        'Análisis de la tasa de cambio y la derivación de funciones',
    'Cálculo integral':
        'Análisis de áreas, volúmenes y la integración de funciones',
    'Geometría analítica':
        'Estudio de las propiedades geométricas mediante técnicas algebraicas',
    'Estadística': 'Análisis de datos, distribuciones y probabilidad',
    'Probabilidad': 'Estudio de los eventos y la posibilidad de que ocurran',
    'Trigonometría':
        'Relaciones entre los ángulos y las medidas de los lados de los triángulos',
    'Funciones\nexponenciales': 'Estudio de funciones con exponentes variables',
    'Funciones logarítmicas':
        'Estudio de funciones inversas a las exponenciales',
    'Geometría euclidiana':
        'Estudio de las propiedades y relaciones de los objetos geométricos en el plano y el espacio'
  };

  final Map<String, String> choicesING = {
    'Grammar': 'Rules and principles governing the use of language',
    'Vocabulary': 'Words and their meanings in a language',
    'Reading Comprehension': 'Understanding and interpreting written texts',
    'Listening Comprehension': 'Understanding and interpreting spoken language',
    'Writing Skills': 'Producing written texts with clarity and coherence',
    'Speaking Skills': 'Expressing ideas and communicating orally',
    'Verb Tenses':
        'Different forms of verbs that indicate when an action occurred',
    'Literary Devices': 'Techniques used by writers to create specific effects',
    'Critical Thinking': 'Analyzing and evaluating information and arguments',
    'Translation': 'Converting text or speech from one language to another',
  };

  final Map<String, String> choicesCIU = {
    'Derechos Humanos':
        'Conjunto de principios que protegen y promueven la dignidad humana',
    'Participación Ciudadana':
        'Involucramiento activo de los ciudadanos en la toma de decisiones',
    'Plebiscito':
        'Consulta popular en la que los ciudadanos votan para tomar decisiones importantes',
    'Democracia':
        'Sistema político donde el poder reside en el pueblo y se ejerce mediante elecciones',
    'Resolución de Conflictos':
        'Proceso de encontrar soluciones pacíficas a situaciones problemáticas',
    'Pluralismo':
        'Aceptación y respeto por las diferentes opiniones y perspectivas en la sociedad',
    'Responsabilidad Social':
        'Compromiso de contribuir al bienestar de la comunidad y el entorno',
    'Cultura Ciudadana':
        'Normas, comportamientos y valores que promueven una convivencia armoniosa',
    'Golpe de Estado':
        'Acción violenta y antidemocrática para tomar el poder de un gobierno',
    'Tutela':
        'Mecanismo legal para proteger los derechos fundamentales de los ciudadanos',
  };

  final Map<String, String> choicesNAT = {
    'Biología': 'Estudio de los seres vivos y su interacción con el entorno',
    'Química':
        'Ciencia que estudia la composición, estructura y propiedades de la materia',
    'Física':
        'Ciencia que estudia las propiedades y el comportamiento de la energía y la materia',
    'Geología':
        'Estudio de la Tierra, su estructura, composición y procesos geológicos',
    'Ecología': 'Estudio de las relaciones entre los seres vivos y su entorno',
    'Genética':
        'Rama de la biología que estudia la herencia y las variaciones genéticas',
    'Ecosistemas':
        'Comunidades de seres vivos y su interacción con el medio ambiente',
    'Energías Renovables':
        'Fuentes de energía que se obtienen de fuentes naturales y sostenibles',
    'Cambios Climáticos':
        'Modificaciones en el clima a largo plazo debido a causas naturales o humanas',
    'Sistema Solar':
        'Conjunto de planetas y otros objetos que orbitan alrededor del Sol',
  };

  final Map<String, String> choicesLEC = {
    'Comprensión de Textos':
        'Habilidad para entender y extraer información de textos escritos',
    'Análisis de Argumentos':
        'Evaluación de la lógica y validez de los argumentos presentados',
    'Inferencias':
        'Deducciones o conclusiones basadas en la información proporcionada',
    'Coherencia y Cohesión':
        'Organización lógica y fluidez en la estructura de los textos',
    'Vocabulario Contextual':
        'Comprensión y uso del vocabulario en función del contexto',
    'Preguntas de\nSelección Múltiple':
        'Respuestas a preguntas con opciones múltiples',
    'Sinónimos y Antónimos': 'Palabras con significados similares o opuestos',
    'Interpretación de Gráficas':
        'Comprensión y análisis de información visual presentada en gráficas',
    'Propósito del Autor':
        'Identificación de la intención o objetivo del autor del texto',
    'Evaluación Crítica':
        'Análisis y juicio sobre la calidad y fiabilidad de la información',
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
    return WillPopScope(
        onWillPop: () async {
          if (intentos < sixChoices.length + 2) {
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
            alignment: Alignment.center,
            children: <Widget>[
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
                        //Fluttertoast.showToast(msg: '$numberOfQuestions
                        if (intentos < sixChoices.length + 2) {
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

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Center(
                        child: Text(
                          "Drag and Drop",
                          style: TextStyle(
                            fontSize: 45.0,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.bold,
                            color: colors_colpaner.claro,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          modul,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.bold,
                            color: colors_colpaner.oscuro,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreBoard1(
                              "Intentos", "$intentos/${sixChoices.length + 2}"),
                          scoreBoard1("Puntos", "${score.length}/5")
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(1, 220, 1, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: sixChoices.keys.map((conceptoAfirmacion) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Draggable<String>(
                              data: conceptoAfirmacion,
                              feedback: ConceptoAfirmacion(
                                conceptoAfirmacion: conceptoAfirmacion,
                              ),
                              childWhenDragging: const ConceptoAfirmacion(
                                  conceptoAfirmacion: '🧐'),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  height: 70,
                                  //CONCEPT INSIDE CARD LEFT
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  color: colors_colpaner.oscuro,
                                  child: ConceptoAfirmacion(
                                      //if concept is correct at draw, then show check emoti in left cards
                                      conceptoAfirmacion:
                                          score[conceptoAfirmacion] == true
                                              ? '✅'
                                              : conceptoAfirmacion),
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (sixChoices.keys.toList()..shuffle())
                          .map((conceptoAfirmacion) {
                        return Column(
                          children: [
                            _buildDragTarget(conceptoAfirmacion),
                            SizedBox(height: 40), // Espacio entre los elementos
                          ],
                        );
                      }).toList(),
                    ),
                  ],
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
                  '¡Correcto!',
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
                intentos >= sixChoices.length + 2) {
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
              intentos >= sixChoices.length + 2) {
            DialogHelper.showDialogGameOver(context, score.length);
            _guardarPuntajeNivel4(score.length);
          }
        });
  }
}

Future<void> _guardarPuntajeNivel4(int score) async {
  final user = FirebaseAuth.instance.currentUser;
  final puntaje = score; // Puntaje obtenido
  LocalStorage localStorage = LocalStorage();

  //obtiene el modulo del shp
  String _modulo = await localStorage.getModulo();

  switch (_modulo) {
    case 'Lectura Crítica':
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreLec4(score);

      //unlock next level
      localStorage.setLecBtn5Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel4')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': score});
      break;

    case 'Razonamiento Cuantitativo':
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreMat4(score);

      //unlock next level
      localStorage.setMatBtn5Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel4')
          .doc(user!.uid);

      //unlock next level
      localStorage.setMatBtn5Unlock();

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': score});
      break;

    case 'Inglés':
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreIng4(score);

      //unlock next level
      localStorage.setIngBtn5Unlock();

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel4')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': score});
      break;

    case 'Ciencias Naturales':
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreNat4(score);

      //unlock next level
      localStorage.setNatBtn5Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('naturales')
          .collection('nivel4')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': score});
      break;

    case 'Competencias Ciudadanas':
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreCiu4(score);

      //unlock next level
      localStorage.setCiuBtn5Unlock();

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ciudadanas')
          .collection('nivel4')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': score});
      break;

    default:
      // Código por defecto si el valor de 'modulo' no coincide con ningún caso
      break;
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
