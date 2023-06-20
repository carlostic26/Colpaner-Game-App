import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';

/*NIVEL TIPO QUIZ 
  Este nivel consiste en desplegar diferentes tipos de preguntas
  El jugador deberá seleccionar una de las opciones.

  El sistema validará la respuesta seleccionada a traves de un aviso sobre la respuesta.

*/

class level1Quiz extends StatefulWidget {
  const level1Quiz({Key? key}) : super(key: key);
  @override
  State<level1Quiz> createState() => _level1QuizState();
}

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 22,
  color: Colors.white,
);

class _level1QuizState extends State<level1Quiz> {
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

  @override
  void initState() {
    super.initState();

    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          Column(
            children: const [
              Expanded(child: QuestionWidget()),
            ],
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
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

//clase que retorna la pregunta en pantalla
class _QuestionWidgetState extends State<QuestionWidget> {
  String _modulo = '';

//recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _getModuloFromSharedPrefs();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const SizedBox(height: 20),
        Stack(children: [
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.end,
              //Banner gamicolpaner
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhIZ0BeUdFWmKEPuHG8oqYPvKvLKbqVNHuiatUdPUCTvlDPUqsGPOjlf-O0VLFKGn1ThkIRpjtJ1xlKFp0q9SMG0pMtdsERgeKUGmOZCxkdgxr_zbyPhJQofnGHIy3jsYoNjp66DeodhoFnRC66yvzxsI9QsE_9lj2SqinF8T9TEMG7N8SYZ08Sb5w/s320/icon.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        //const SizedBox(height: 10),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Container(
            alignment: Alignment.bottomRight,
            child: Text(
              //TEXTO QUE CONTIENE EL PONDERADO  DE PREGUNTAS
              'Pregunta $_questionNumber/5',
              style: const TextStyle(
                  color: colors_colpaner.oscuro,
                  fontFamily: 'BubblegumSans',
                  fontSize: 15.0),
            ),
          ),
        ),
        //Se imprime el pageView que contiene pregunta y opciones
        Expanded(
            child: PageView.builder(
                itemCount: 5,
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: _modulo == 'Razonamiento Cuantitativo'
                    ? (context, index) {
                        final _question = questionsMat[index];
                        return buildQuestion(_question);
                      }
                    : _modulo == 'Inglés'
                        ? (context, index) {
                            final _question = questionsIng[index];
                            return buildQuestion(_question);
                          }
                        : _modulo == 'Ciencias Naturales'
                            ? (context, index) {
                                final _question = questionsNat[index];
                                return buildQuestion(_question);
                              }
                            : _modulo == 'Competencias Ciudadanas'
                                ? (context, index) {
                                    final _question = questionsCiu[index];
                                    return buildQuestion(_question);
                                  }
                                : _modulo == 'Lectura Crítica'
                                    ? (context, index) {
                                        final _question = questionsLec[index];
                                        return buildQuestion(_question);
                                      }
                                    : (context, index) {
                                        final _question = questionsMat[index];
                                        return buildQuestion(_question);
                                      })),
        _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
        const SizedBox(height: 20),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Padding buildQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //altura del cuerpo que contiene pregunta y respuestas
          const SizedBox(height: 30),

          Text(
            //TEXTO QUE CONTIENE LA PREGUNTA COMPLETA
            question.text,
            style: const TextStyle(
                color: colors_colpaner.claro,
                fontFamily: 'BubblegumSans',
                fontSize: 20.0),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: OptionsWidget(
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if (question.selectedOption!.isCorrect) {
                  _score++;
                }
              }
            },
          ))
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_questionNumber < 5) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(score: _score),
            ),
          );

          await _guardarPuntajeNivel1(
              _score); // Llamar a la función para guardar el puntaje
        }

        // Se carga la información de puntaje a la base de datos logrando actualizar todo el campo del registro de puntaje correspondiente al nivel
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors_colpaner.claro, // Background color
        minimumSize: const Size(100, 40),
      ),
      child: Text(
        _questionNumber < 5 ? 'Siguiente' : 'Revisar resultado',
        style: const TextStyle(
            color: colors_colpaner.oscuro,
            fontFamily: 'BubblegumSans',
            fontSize: 25.0),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  //devuelve graficamente las opciones de respuestas en pantalla
  @override
  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: 80, //altura de las tarjetas de cada opcion
        padding: const EdgeInsets.fromLTRB(3, 1, 1, 1),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          //color of cards options
          color: colors_colpaner.oscuro, //189, 40, 13
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  option.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'BubblegumSans',
                      fontSize: 14.0),
                ),
              ),
              getIconForOption(option, question)
            ],
          ),
        ),
      ),
    );
  }

//Método que devuelve un color como forma de validación de respuesta por el usuario
  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }

    return Colors.grey.shade300;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelect = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelect) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.orange);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }
}

class Question {
  late final String text;
  late final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

//https://es.wikipedia.org/wiki/ICFES

final questionsMat = [
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Razonamiento Cuantitativo del ICFES Saber 11?",
    options: [
      const Option(
          text:
              'A. Un conjunto de preguntas sobre temas diversos sin un orden específico, pero que tratan sobre las matematicas básicas.',
          isCorrect: false),
      const Option(
          text:
              'B. conjunto de elementos de las matemáticas, que permiten al ciudadano tomar parte activa e informada en los contextos social, cultural, político, administrativo, económico, educativo y laboral. ',
          isCorrect: true),
      const Option(
          text:
              'C. Un examen aparte que los estudiantes pueden tomar para evaluar su habilidad en Razonamiento Cuantitativo.',
          isCorrect: false),
      const Option(
          text:
              'D. Un conjunto de ejercicios que los estudiantes pueden hacer para practicar Razonamiento Cuantitativo antes del examen, y aumentar la probabilidad de exito.',
          isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Qué temas se evalúan en el módulo de Razonamiento Cuantitativo del ICFES?",
      options: [
        const Option(
            text: 'A. Álgebra, geometría, trigonometría y estadística.',
            isCorrect: false),
        const Option(
            text: 'B. Álgebra, cálculo, geometría y estadística.',
            isCorrect: true),
        const Option(
            text: 'C. Álgebra, cálculo, trigonometría y geometría analítica.',
            isCorrect: false),
        const Option(
            text: 'D. Álgebra, cálculo, estadística y geometría analítica.',
            isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuántas preguntas aproximadamente se evalúan en el módulo de Razonamiento Cuantitativo del ICFES?",
      options: [
        const Option(text: 'A. 20 preguntas', isCorrect: false),
        const Option(text: 'B. 30 preguntas', isCorrect: false),
        const Option(text: 'C. 35 preguntas', isCorrect: true),
        const Option(text: 'D. 45 preguntas', isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál es el tiempo ideal para completar el módulo de Razonamiento de la prueba?',
      options: [
        const Option(text: 'A. 90 minutos', isCorrect: false),
        const Option(text: 'B. 100 minutos', isCorrect: false),
        const Option(text: 'C. 120 minutos', isCorrect: false),
        const Option(text: 'D. 150 minutos', isCorrect: true)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Pueden los estudiantes utilizar calculadoras en el módulo de Razonamiento Cuantitativo del ICFES?",
      options: [
        const Option(
            text: 'A. Sí, pero solo se permite el uso de calculadoras básicas.',
            isCorrect: true),
        const Option(
            text: 'B. Sí, se permite el uso de cualquier tipo de calculadora.',
            isCorrect: false),
        const Option(
            text: 'C. No, el uso de calculadoras está prohibido.',
            isCorrect: false),
        const Option(
            text: 'D. Depende del tipo de preguntas que se presenten.',
            isCorrect: false)
      ]),
];

final questionsIng = [
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text: "1. ¿Qué es el módulo de inglés en el ICFES?",
    options: [
      const Option(
          text:
              'A. Es un examen para evaluar el nivel de competencia en los idiomas.',
          isCorrect: false),
      const Option(
          text:
              'B. Es un módulo opcional que los estudiantes pueden tomar para obtener puntajes adicionales.',
          isCorrect: false),
      const Option(
          text:
              'C. Es un examen para evaluar el nivel de competencia en el idioma inglés.',
          isCorrect: true),
      const Option(
          text:
              'D. Es un módulo que evalúa la habilidad para enseñar inglés a otros.',
          isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text: "2. ¿Cuál es el objetivo del ICFES al evaluar el módulo de inglés?",
      options: [
        const Option(
            text:
                'A. Evaluar la capacidad de los estudiantes para enseñar inglés.',
            isCorrect: false),
        const Option(
            text:
                'B. Evaluar la capacidad de los estudiantes para comunicarse en inglés.',
            isCorrect: true),
        const Option(
            text:
                'C. Evaluar la capacidad de los estudiantes para comprender la literatura en inglés.',
            isCorrect: false),
        const Option(
            text:
                'D. Evaluar la capacidad de los estudiantes para realizar traducciones.',
            isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuántas preguntas aproximadamente evalúa el ICFES en el módulo de inglés?",
      options: [
        const Option(text: 'A. 20', isCorrect: false),
        const Option(text: 'B. 35', isCorrect: false),
        const Option(text: 'C. 45', isCorrect: false),
        const Option(text: 'D. 55', isCorrect: true)
      ]),

  //Pregunta 4
  Question(
      text: '4. ¿Qué habilidades evalúa el módulo de inglés del ICFES?',
      options: [
        const Option(text: 'A. Comprensión de lectura.', isCorrect: false),
        const Option(text: 'B. Expresión oral y escrita.', isCorrect: false),
        const Option(
            text: 'C. Conocimiento gramatical y léxico.', isCorrect: false),
        const Option(text: 'D. Todas las anteriores.', isCorrect: true)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. 4. ¿Cuál es el tiempo ideal para completar el módulo de Inglés de la prueba?",
      options: [
        const Option(text: 'A. 60 minutos', isCorrect: false),
        const Option(text: 'B. 75 minutos', isCorrect: true),
        const Option(text: 'C. 90 minutos', isCorrect: false),
        const Option(text: 'D. 120 minutos', isCorrect: false)
      ]),
];

final questionsNat = [
  //Pregunta 1
  Question(
    text: "1. ¿Qué es el modulo de Ciencias Naturales del ICFES Saber 11? ",
    options: [
      const Option(
          text:
              'A. Es una sección de la prueba que evalúa el conocimiento y comprensión de los estudiantes en quimica y fisica.',
          isCorrect: false),
      const Option(
          text:
              'B. Es una sección de la prueba que evalúa el conocimiento y comprensión de los estudiantes sobre la tabla periódica y otros temas.',
          isCorrect: false),
      const Option(
          text:
              'C. Es una sección de la prueba que evalúa el conocimiento y comprensión de los estudiantes en biología, física, química y la relación entre ciencia, tecnología y sociedad. ',
          isCorrect: true),
      const Option(text: 'D. Ninguna de las anteriores.', isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuantas preguntas contiene la prueba de Ciencias Naturales del ICFES Saber PRO? ",
      options: [
        const Option(
            text: 'A. 29 en la sesión 1 y 32 en la sesión 2', isCorrect: false),
        const Option(
            text: 'B. 29 en la sesión 1 y 29 en la sesión 2', isCorrect: true),
        const Option(
            text: 'C. 32 en la sesión 1 y 32 en la sesón 2', isCorrect: false),
        const Option(text: 'D. 29 en un sola sesión', isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Qué evalua el modulo de Ciencias Naturales del examen ICFES Saber 11?)",
      options: [
        const Option(
            text:
                'A. la capacidad del estudiante para comprender y usar nociones, conceptos y teorías de las ciencias naturales en la solución de problemas',
            isCorrect: true),
        const Option(
            text:
                'B. la capacidad del estudiante para el análisis y comprensión, formulación y representación, interpretación y argumentación sobre química',
            isCorrect: false),
        const Option(
            text:
                'C. la capacidad del estudiante sobre la investigación, ejecución, interpretación, formulación y argumentación de las Ciencias Naturales',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál es el tiempo ideal para completar el módulo de Ciencias Naturales de la prueba?',
      options: [
        const Option(text: 'A. Entre 25 a 30 minutos.', isCorrect: false),
        const Option(text: 'B. Entre 30 a 40 minutos.', isCorrect: false),
        const Option(text: 'C. Entre 40 a 45 minutos..', isCorrect: true),
        const Option(text: 'D. Entre 45 a 50 minutos.', isCorrect: false)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Cuales componentes del módulo de Ciencias Naturales se envalúan en la prueba?",
      options: [
        const Option(
            text:
                'A. Componente químico, componente biológico, componente físico.',
            isCorrect: false),
        const Option(
            text:
                'B. Componente naturales, componente biológico, componente físico, componente tecnológico.',
            isCorrect: false),
        const Option(
            text:
                'C. Componente químico, componente biológico, componente físico, componente de ciencia.',
            isCorrect: false),
        const Option(
            text:
                'D. Componente químico, componente biológico, componente físico, componente de ciencia, tecnologia y sociedad (CTS).',
            isCorrect: true)
      ]),
];

final questionsLec = [
  //Pregunta 1
  Question(
    text: "¿Qué es lectura crítica?",
    options: [
      const Option(
          text:
              'A. Es la habilidad de leer rápida y superficialmente para obtener la información más importante de un texto.',
          isCorrect: false),
      const Option(
          text:
              'B. Es la habilidad de comprender el significado literal de un texto sin analizar sus implicaciones más profundas.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la habilidad de evaluar la información presentada en un texto y hacer juicios informados sobre su calidad y relevancia.',
          isCorrect: true),
      const Option(
          text:
              'D. Es la habilidad de memorizar y repetir información textual de manera precisa.',
          isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuántas preguntas de lectura crítica tiene aproximadamente el ICFES Saber 11?",
      options: [
        const Option(text: 'A. 13', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: false),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 41', isCorrect: true)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuál de las siguientes afirmaciones NO es una habilidad asociada con la lectura crítica?",
      options: [
        const Option(
            text: 'A. Comprender el sentido global de un texto.',
            isCorrect: false),
        const Option(
            text: 'B. Identificar la información explícita en un texto.',
            isCorrect: false),
        const Option(
            text:
                'C. Evaluar la calidad de los argumentos presentados en un texto.',
            isCorrect: false),
        const Option(
            text: 'D. Memorizar datos y detalles del texto.', isCorrect: true)
      ]),

  //Pregunta 4
  Question(
      //
      text:
          '4. ¿Cuáles son las competencias y habilidades del estudiante para la comprensión, interpretación y evaluación de textos cotidianos y de ámbitos académicos no especializados que evalua el ICFES Saber 11?',
      options: [
        const Option(
            text:
                'A. Evaluar la habilidad de los estudiantes para identificar y entender los contenidos locales que conforman un texto, que evalúa la comprensión de palabras, frases o expresiones',
            isCorrect: false),
        const Option(
            text:
                'B. Reflexionar a partir de un texto y evaluar su contenido, en la cual se evalúa la capacidad de enfrentarse a un texto de manera crítica. ',
            isCorrect: false),
        const Option(
            text:
                'C. Comprender cómo se articulan las partes de un texto para darle un sentido global, relacionada con la comprensión de las partes del texto para la articulación del sentido global. ',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores.', isCorrect: true)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Cuánto tiempo debo tomar en resolver todo el módulo de lectura crítica?",
      options: [
        const Option(text: 'A. Entre 15 a 25 minutos', isCorrect: false),
        const Option(text: 'B. Entre 25 a 35 minutos', isCorrect: false),
        const Option(text: 'C. Entre 35 a 50 minutos', isCorrect: false),
        const Option(text: 'D. Entre 50 y 65 minutos', isCorrect: true)
      ]),
];

final questionsCiu = [
  //Pregunta 1
  Question(
    text: "1. ¿Qué es son las Competencias Ciudadanas? ",
    options: [
      const Option(
          text: 'A. Es una sección que evalúa el ICFES.', isCorrect: false),
      const Option(
          text:
              'B. Son el conjunto de actividades normativas dedicadas al proceso de creación y publicación de leyes.',
          isCorrect: false),
      const Option(
          text:
              'C. Son el conjunto de planificaciones sociales lideradas por la ciudadania',
          isCorrect: false),
      const Option(
          text:
              'D. Son el conjunto de conocimientos, habilidades, actitudes y valores que permiten a las personas participar de manera activa y responsable en la sociedad',
          isCorrect: true)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Qué es el módulo de Competencias Ciudadanas del examen ICFES Saber 11? ",
      options: [
        const Option(
            text:
                'A. Es una sección del examen que evalúa el análisis de la información relacionada con política, economía y cultura',
            isCorrect: true),
        const Option(
            text:
                'B. Es una sección del examen que evalúa el análisis de la información relacionada con la ciudad, ecología y cultura',
            isCorrect: false),
        const Option(
            text:
                'C. Es una sección del examen que evalúa el análisis de datos sobre política, economía y cultura',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text: '3. ¿Qué se evalúa en la prueba de Competencias Ciudadanas?',
      options: [
        const Option(
            text:
                'A. pensamientos reflexivos y sistemicos sobre como funciona una nación.',
            isCorrect: false),
        const Option(
            text:
                'B. pensamiento logico, interpretación de análisis y pensamiento filosofico.',
            isCorrect: false),
        const Option(
            text:
                'C.  pensamiento social, interpretación y análisis de perspectivas y pensamiento reflexivo y sistémico.',
            isCorrect: true),
        const Option(text: 'D. Ninguna de las anteriores', isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text: "4. ¿Qué NO se evalua el modulo de Competencias Ciudadanas?",
      options: [
        const Option(
            text: 'A. Pensamiento social del estudiante', isCorrect: false),
        const Option(
            text:
                'B. Opinión o postura del estudiante sobre determinados asuntos ciudadanos.',
            isCorrect: true),
        const Option(
            text: 'C. Interpretación y análisis de perspectivas del estudiante',
            isCorrect: false),
        const Option(
            text: 'D. Pensamiento reflexivo y sistémico del estudiante.',
            isCorrect: false)
      ]),

  //Pregunta 5

  Question(
    text:
        "5. ¿Cuál es el tiempo ideal para completar el módulo de Competencias Ciudadanas del ICFES?",
    options: [
      const Option(text: 'A. Entre 5 y 10 minutos', isCorrect: false),
      const Option(text: 'B. Entre 15 y 20 minutos', isCorrect: false),
      const Option(text: 'C. Entre 25 y 30 minutos', isCorrect: true),
      const Option(text: 'D. Entre 35 y 40 minutos', isCorrect: false)
    ],
  ),
];

Future<void> _guardarPuntajeNivel1(int score) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final user = FirebaseAuth.instance.currentUser;
  final puntaje = score; // Puntaje obtenido

  LocalStorage localStorage = LocalStorage();

  //obtiene el modulo del shp
  String _modulo = await getModulo();

  if (_modulo == 'Razonamiento Cuantitativo') {
    //no lo tiene por que escribir en shp porque nunca se escribirá  puntajes a shp, solo se lee de firestore, mas no escribir
    /*  //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntajes_MAT', score); */

    final puntajesRefMat = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel1')
        .doc(user!.uid);

    await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Inglés') {
    //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntaje_ing_1', score);

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel1')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Lectura Crítica') {
/*     //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntaje_lec_1', score); */

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel1')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Ciencias Naturales') {
/*     //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntaje_lec_1', score); */

    final puntajesRefSoc = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel1')
        .doc(user!.uid);

    await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Competencias Ciudadanas') {
/*     //establece el puntaje obtenido y lo guarda en shp
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('puntaje_lec_1', score); */

    final puntajesRefCiu = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel1')
        .doc(user!.uid);

    await puntajesRefCiu.set({'userId': user.uid, 'puntaje': puntaje});
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    String _modulo = '';

    //recibe el modulo guardado anteriormente en sharedPreferences
    void _getModuloFromSharedPrefs() async {
      final prefs = await SharedPreferences.getInstance();

      _modulo = prefs.getString('modulo') ?? '';
    }

    return Stack(
      children: <Widget>[
        //CONTAINER DEL FONDO QUE CONTIENE IMAGEN DE FONDO LADRILLOS
        Container(
          decoration: const BoxDecoration(color: colors_colpaner.oscuro),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
        ),
        Scaffold(
          backgroundColor: colors_colpaner.base,
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Obtuviste $score/${5}\n  Puntaje: + $score',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'BubblegumSans',
                          fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors_colpaner
                              .base, // utilizar el color de fondo deseado en lugar de Colors.blue
                          foregroundColor: Colors
                              .white, // opcional, color del texto y del icono
                          elevation: 4, // opcional, la elevación del botón
                          shape: RoundedRectangleBorder(
                            // opcional, la forma del botón
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const misPuntajes()));
                        },
                        child: const Text(
                          'Mis Puntajes',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'BubblegumSans'),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //BUTTON NEXT
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const world_game()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colors_colpaner.base,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Icon(
                          Icons.navigate_next,
                          size: 30,
                        ),
                      ),
                    ],
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
          ]),
        ),
      ],
    );
  }
}
