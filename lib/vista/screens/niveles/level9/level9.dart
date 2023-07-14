import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*NIVEL TIPO QUIZ 
  Este nivel consiste en desplegar diferentes tipos de preguntas
  El jugador deberá seleccionar una de las opciones.

  El sistema validará la respuesta seleccionada a traves de un aviso sobre la respuesta.

*/

class level9Quiz extends StatefulWidget {
  const level9Quiz({Key? key}) : super(key: key);
  @override
  State<level9Quiz> createState() => _level9QuizState();
}

class _level9QuizState extends State<level9Quiz> {
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
                        final question = questionsMat[index];
                        return buildQuestion(question);
                      }
                    : _modulo == 'Inglés'
                        ? (context, index) {
                            final question = questionsIng[index];
                            return buildQuestion(question);
                          }
                        : _modulo == 'Ciencias Naturales'
                            ? (context, index) {
                                final question = questionsNat[index];
                                return buildQuestion(question);
                              }
                            : _modulo == 'Competencias Ciudadanas'
                                ? (context, index) {
                                    final question = questionsSoc[index];
                                    return buildQuestion(question);
                                  }
                                : _modulo == 'Lectura Crítica'
                                    ? (context, index) {
                                        final question = questionsLec[index];
                                        return buildQuestion(question);
                                      }
                                    : (context, index) {
                                        final question = questionsMat[index];
                                        return buildQuestion(question);
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
                      fontSize: 16.0),
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

final questionsMat = [
  // Pregunta 1
  Question(
    text:
        "1. Si un automóvil recorre 360 kilómetros en 6 horas, ¿cuál es su velocidad promedio en kilómetros por hora?",
    options: [
      const Option(text: 'A. 40 km/h', isCorrect: false),
      const Option(text: 'B. 50 km/h', isCorrect: false),
      const Option(text: 'C. 60 km/h', isCorrect: true),
      const Option(text: 'D. 70 km/h', isCorrect: false),
    ],
  ),

  // Pregunta 2
  Question(
    text:
        "2. En una tienda, el precio de una camiseta es de 💲30. Si se aplica un descuento del 25%, ¿cuál será el precio final de la camiseta?",
    options: [
      const Option(text: 'A. 💲18', isCorrect: false),
      const Option(text: 'B. 💲22.50', isCorrect: true),
      const Option(text: 'C. 💲25.55', isCorrect: false),
      const Option(text: 'D. 💲35', isCorrect: false),
    ],
  ),

  // Pregunta 3
  Question(
    text:
        "3. Si un número aumenta en un 20% y luego se reduce en un 15%, ¿cuál es el cambio porcentual neto?",
    options: [
      const Option(text: 'A. 5%', isCorrect: false),
      const Option(text: 'B. 2%', isCorrect: false),
      const Option(text: 'C. 3%', isCorrect: true),
      const Option(text: 'D. 35%', isCorrect: false),
    ],
  ),

  // Pregunta 4
  Question(
    text:
        "4. Un artículo se vende con un margen de beneficio del 40% sobre el costo de producción. Si el costo de producción es de 💲80, ¿cuál es el precio de venta del artículo?",
    options: [
      const Option(text: 'A. 💲112', isCorrect: true),
      const Option(text: 'B, 💲100', isCorrect: false),
      const Option(text: 'C. 💲120', isCorrect: false),
      const Option(text: 'D. 💲160', isCorrect: false),
    ],
  ),

  // Pregunta 5
  Question(
    text:
        "5. Si un triángulo tiene una base de 8 cm y una altura de 10 cm, ¿cuál es su área?",
    options: [
      const Option(text: 'A. 24 cm²', isCorrect: false),
      const Option(text: 'B. 40 cm²', isCorrect: true),
      const Option(text: 'C. 48 cm²', isCorrect: false),
      const Option(text: 'D. 80 cm²', isCorrect: false),
    ],
  ),
];

final questionsIng = [
  // Pregunta 1
  Question(
    text: "1. Which of the following sentences is grammatically correct?",
    options: [
      const Option(text: 'A. She don\'t like coffee.', isCorrect: false),
      const Option(text: 'B. They is going to the party.', isCorrect: false),
      const Option(text: 'C. He has been studying all day.', isCorrect: true),
      const Option(text: 'D. We am excited for the trip.', isCorrect: false)
    ],
  ),

  // Pregunta 2
  Question(
    text: "2. What is the correct form of the verb to be in the past tense?",
    options: [
      const Option(text: 'A. Am', isCorrect: false),
      const Option(text: 'B. Is', isCorrect: false),
      const Option(text: 'C. Were', isCorrect: true),
      const Option(text: 'D. Be', isCorrect: false)
    ],
  ),

  // Pregunta 3
  Question(
    text: "3. Which of the following words is a synonym for 'happy'?",
    options: [
      const Option(text: 'A. Sad', isCorrect: false),
      const Option(text: 'B. Angry', isCorrect: false),
      const Option(text: 'C. Joyful', isCorrect: true),
      const Option(text: 'D. Tired', isCorrect: false)
    ],
  ),

  // Pregunta 4
  Question(
    text: "4. What is the correct order of words in an interrogative sentence?",
    options: [
      const Option(text: 'A. Subject - Verb - Object', isCorrect: false),
      const Option(text: 'B. Object - Verb - Subject', isCorrect: false),
      const Option(text: 'C. Verb - Subject - Object', isCorrect: false),
      const Option(text: 'D. Verb - Subject', isCorrect: true)
    ],
  ),

  // Pregunta 5
  Question(
    text:
        "5. Which of the following sentences uses the present perfect tense correctly?",
    options: [
      const Option(
          text: 'A. I have went to the store yesterday.', isCorrect: false),
      const Option(
          text: 'B. They has seen that movie before.', isCorrect: false),
      const Option(
          text: 'C. She has already finished her homework.', isCorrect: true),
      const Option(
          text: 'D. We have not went to the party yet.', isCorrect: false)
    ],
  ),
];

final questionsNat = [
  // Pregunta 1
  Question(
    text:
        "1. ¿Cuál de los siguientes componentes no es parte de una célula eucariota?",
    options: [
      const Option(text: 'A. Núcleo', isCorrect: false),
      const Option(text: 'B. Membrana plasmática', isCorrect: false),
      const Option(text: 'C. Ribosomas', isCorrect: false),
      const Option(text: 'D. Pared celular', isCorrect: true),
    ],
  ),

  // Pregunta 2
  Question(
    text:
        "2. ¿Cuál de los siguientes órganos es parte del sistema respiratorio humano?",
    options: [
      const Option(text: 'A. Páncreas', isCorrect: false),
      const Option(text: 'B. Riñón', isCorrect: false),
      const Option(text: 'C. Pulmón', isCorrect: true),
      const Option(text: 'D. Hígado', isCorrect: false),
    ],
  ),

  // Pregunta 3
  Question(
    text:
        "3. ¿Cuál de los siguientes procesos es una fuente de energía renovable?",
    options: [
      const Option(text: 'A. Gas natural', isCorrect: false),
      const Option(text: 'B. Carbón', isCorrect: false),
      const Option(text: 'C. Petróleo', isCorrect: false),
      const Option(text: 'D. Energía solar', isCorrect: true),
    ],
  ),

  // Pregunta 4
  Question(
    text:
        "4. ¿Cuál de los siguientes elementos químicos es el más abundante en la Tierra?",
    options: [
      const Option(text: 'A. Hierro', isCorrect: false),
      const Option(text: 'B. Oxígeno', isCorrect: true),
      const Option(text: 'C. Carbono', isCorrect: false),
      const Option(text: 'D. Aluminio', isCorrect: false),
    ],
  ),

  // Pregunta 5
  Question(
    text: "5. ¿Cuál de las siguientes enfermedades es causada por un virus?",
    options: [
      const Option(text: 'A. Diabetes', isCorrect: false),
      const Option(text: 'B. Tuberculosis', isCorrect: false),
      const Option(text: 'C. VIH/SIDA', isCorrect: true),
      const Option(text: 'D. Asma', isCorrect: false),
    ],
  ),
];

final questionsLec = [
  // Pregunta 1
  Question(
    text:
        "1. ¿Cuál de los siguientes enunciados resume mejor la idea principal de un texto?",
    options: [
      const Option(
          text:
              'A. Detalla los argumentos presentados en cada párrafo del texto.',
          isCorrect: false),
      const Option(
          text: 'B. Resume la opinión del autor sobre el tema.',
          isCorrect: false),
      const Option(
          text: 'C. Destaca la información más relevante y general del texto.',
          isCorrect: true),
      const Option(
          text: 'D. Enumera los datos estadísticos mencionados en el texto.',
          isCorrect: false)
    ],
  ),

  // Pregunta 2
  Question(
    text:
        "2. ¿Cuál de las siguientes estrategias es más efectiva para mejorar la comprensión lectora?",
    options: [
      const Option(
          text: 'A. Leer rápidamente sin prestar atención a los detalles.',
          isCorrect: false),
      const Option(
          text: 'B. Analizar minuciosamente cada palabra del texto.',
          isCorrect: false),
      const Option(
          text: 'C. Evitar la lectura de textos extensos.', isCorrect: false),
      const Option(
          text: 'D. Identificar las ideas principales y secundarias del texto.',
          isCorrect: true)
    ],
  ),

  // Pregunta 3
  Question(
    text:
        "3. ¿Cuál de las siguientes opciones describe mejor el propósito de un párrafo de transición en un texto?",
    options: [
      const Option(
          text: 'A. Brindar información adicional sobre un tema específico.',
          isCorrect: false),
      const Option(
          text: 'B. Plantear una pregunta retórica sin responderla.',
          isCorrect: false),
      const Option(
          text:
              'C. Introducir una nueva idea o tema relacionado con el anterior.',
          isCorrect: true),
      const Option(
          text: 'D. Concluir el texto y resumir las ideas principales.',
          isCorrect: false)
    ],
  ),

  // Pregunta 4
  Question(
    text:
        "4. ¿Cuál de las siguientes acciones NO es útil para mejorar la comprensión lectora?",
    options: [
      const Option(
          text: 'A. Subrayar o resaltar las ideas principales del texto.',
          isCorrect: false),
      const Option(
          text: 'B. Realizar preguntas sobre el contenido del texto.',
          isCorrect: false),
      const Option(
          text: 'C. Leer diferentes tipos de textos y géneros literarios.',
          isCorrect: false),
      const Option(
          text:
              'D. Leer únicamente la primera y última oración de cada párrafo.',
          isCorrect: true)
    ],
  ),

  // Pregunta 5
  Question(
    text:
        "5. ¿Cuál de las siguientes opciones describe mejor el propósito de un párrafo introductorio en un texto?",
    options: [
      const Option(
          text: 'A. Resumir todas las ideas principales del texto.',
          isCorrect: false),
      const Option(
          text: 'B. Proporcionar detalles específicos sobre un tema.',
          isCorrect: false),
      const Option(
          text: 'C. Introducir el tema y establecer el contexto del texto.',
          isCorrect: true),
      const Option(
          text: 'D. Plantear una pregunta sin responderla.', isCorrect: false)
    ],
  ),
];

final questionsSoc = [
  // Pregunta 1
  Question(
    text:
        "1. ¿Cuál de las siguientes acciones ejemplifica mejor la responsabilidad ciudadana?",
    options: [
      const Option(
          text: 'A. Participar activamente en actividades deportivas.',
          isCorrect: false),
      const Option(
          text:
              'B. Cumplir con las leyes y normas establecidas en la sociedad.',
          isCorrect: true),
      const Option(
          text: 'C. Evitar el contacto con personas de diferentes culturas.',
          isCorrect: false),
      const Option(
          text: 'D. Priorizar el interés personal sobre el bien común.',
          isCorrect: false)
    ],
  ),

  // Pregunta 2
  Question(
    text:
        "2. ¿Cuál de las siguientes habilidades NO es esencial para el desarrollo de competencias ciudadanas? ",
    options: [
      const Option(text: 'A. Empatía hacia los demás.', isCorrect: false),
      const Option(
          text: 'B. Capacidad de análisis y pensamiento crítico.',
          isCorrect: false),
      const Option(
          text: 'C. Conocimiento profundo de matemáticas avanzadas.',
          isCorrect: true),
      const Option(text: 'D. Toma de decisiones éticas.', isCorrect: false)
    ],
  ),

  // Pregunta 3
  Question(
    text:
        "3. ¿Cuál de las siguientes opciones describe mejor la importancia de la participación ciudadana en la democracia?",
    options: [
      const Option(
          text: 'A. Irrelevante, decisiones tomadas por líderes políticos.',
          isCorrect: false),
      const Option(
          text:
              'B. Fundamental, ciudadanos ejercen derecho a opinar y contribuir en decisiones.',
          isCorrect: true),
      const Option(
          text:
              'C. Opcional, líderes políticos toman decisiones en beneficio de la sociedad.',
          isCorrect: false),
      const Option(
          text:
              'D. Perjudicial, puede llevar a conflictos y desacuerdos entre ciudadanos.',
          isCorrect: false)
    ],
  ),

  // Pregunta 4
  Question(
    text:
        '4. ¿Cuál de los siguientes valores NO es fundamental en el desarrollo de competencias ciudadanas?',
    options: [
      const Option(
          text: 'A. Tolerancia hacia la diversidad.', isCorrect: false),
      const Option(
          text: 'B. Solidaridad con los menos favorecidos.', isCorrect: false),
      const Option(text: 'C. Deshonestidad y falta de ética.', isCorrect: true),
      const Option(
          text: 'D. Respeto por los derechos humanos.', isCorrect: false)
    ],
  ),

  // Pregunta 5
  Question(
    text:
        "5. ¿Cuál de las siguientes opciones describe mejor la importancia de la convivencia pacífica en una sociedad?",
    options: [
      const Option(
          text: 'A. Genera conflictos y tensiones entre los ciudadanos.',
          isCorrect: false),
      const Option(
          text: 'B. Limita la libertad individual y la expresión personal.',
          isCorrect: false),
      const Option(
          text: 'C. Promueve la armonía y el respeto mutuo entre las personas.',
          isCorrect: true),
      const Option(
          text: 'D. Excluye a los grupos minoritarios de la sociedad.',
          isCorrect: false)
    ],
  ),
];

Future<void> _guardarPuntajeNivel1(int score) async {
  final user = FirebaseAuth.instance.currentUser;
  final puntaje = score; // Puntaje obtenido
  LocalStorage localStorage = LocalStorage();

  //obtiene el modulo del shp
  String _modulo = await localStorage.getModulo();

  if (_modulo == 'Razonamiento Cuantitativo') {
    //save score in shared preferente to save resources at firebase
    localStorage.setScoreMat9(score);

    //unlock next level
    localStorage.setMatBtn10Unlock();

    final puntajesRefMat = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel9')
        .doc(user!.uid);

    //unlock next level
    localStorage.setMatBtn10Unlock();

    await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Inglés') {
    //save score in shared preferente to save resources at firebase
    localStorage.setScoreIng9(score);

    //unlock next level
    localStorage.setIngBtn10Unlock();

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel9')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Lectura Crítica') {
    //save score in shared preferente to save resources at firebase
    localStorage.setScoreLec9(score);

    //unlock next level
    localStorage.setLecBtn10Unlock();

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel9')
        .doc(user!.uid);

    await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Ciencias Naturales') {
    //save score in shared preferente to save resources at firebase
    localStorage.setScoreNat9(score);

    //unlock next level
    localStorage.setNatBtn10Unlock();

    final puntajesRefSoc = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel9')
        .doc(user!.uid);

    await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Competencias Ciudadanas') {
    //save score in shared preferente to save resources at firebase
    localStorage.setScoreCiu9(score);

    //unlock next level
    localStorage.setCiuBtn10Unlock();

    final puntajesRefCiu = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel9')
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
          decoration: const BoxDecoration(color: colors_colpaner.base),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Column(
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
                            .oscuro, // utilizar el color de fondo deseado en lugar de Colors.blue
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                        primary: colors_colpaner.oscuro,
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
