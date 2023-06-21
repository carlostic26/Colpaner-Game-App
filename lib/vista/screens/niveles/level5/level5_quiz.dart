import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*NIVEL TIPO QUIZ 
  Este nivel consiste en desplegar diferentes tipos de preguntas
  El jugador deberá seleccionar una de las opciones.

  El sistema validará la respuesta seleccionada a traves de un aviso sobre la respuesta.

*/

class level5Quiz extends StatefulWidget {
  const level5Quiz({Key? key}) : super(key: key);
  @override
  State<level5Quiz> createState() => _level5QuizState();
}

TextStyle customTextStyle = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontSize: 24,
  color: Colors.white,
);

class _level5QuizState extends State<level5Quiz> {
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
                                    final _question = questionsSoc[index];
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
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text:
        "1. ¿Cuál de las siguientes opciones describe mejor el concepto de proporcionalidad? ",
    options: [
      const Option(
          text:
              'A. La relación entre dos cantidades en la que su cociente es constante.',
          isCorrect: false),
      const Option(
          text: 'B. La suma de dos o más cantidades.', isCorrect: false),
      const Option(
          text: 'C. La diferencia entre dos cantidades.', isCorrect: true),
      const Option(
          text: 'D. La multiplicación de dos o más cantidades.',
          isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuál de las siguientes operaciones se utiliza para encontrar el área de un rectángulo? ",
      options: [
        const Option(
            text: 'A. Multiplicar la longitud por la anchura.',
            isCorrect: false),
        const Option(
            text: 'B. Dividir la longitud entre la anchura.', isCorrect: true),
        const Option(
            text: 'C. Sumar la longitud y la anchura.', isCorrect: false),
        const Option(
            text: 'D. Restar la longitud y la anchura.', isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuál de las siguientes opciones describe mejor el concepto de promedio (media aritmética)?",
      options: [
        const Option(
            text:
                'A.  La diferencia entre el número más grande y el número más pequeño en un conjunto de datos. ',
            isCorrect: false),
        const Option(
            text:
                'B.  La suma de todos los números en un conjunto de datos dividida por la cantidad de números.',
            isCorrect: true),
        const Option(
            text:
                'C. El número que ocurre con mayor frecuencia en un conjunto de datos.',
            isCorrect: false),
        const Option(
            text:
                'D. La raíz cuadrada del producto de todos los números en un conjunto de datos.',
            isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4: ¿Cuál de las siguientes opciones describe mejor el concepto de probabilidad? ',
      options: [
        const Option(
            text:
                'A. La medida de la tendencia central en un conjunto de datos.',
            isCorrect: false),
        const Option(
            text:
                'B. La proporción de eventos favorables en relación con el número total de eventos posibles.',
            isCorrect: true),
        const Option(
            text: 'C. El número más común en un conjunto de datos.',
            isCorrect: false),
        const Option(
            text: 'D. El valor medio de un conjunto de datos.',
            isCorrect: false)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Cuál de las siguientes opciones describe mejor el concepto de fracción?",
      options: [
        const Option(
            text: 'A. Un número entero mayor que 1.', isCorrect: false),
        const Option(
            text: 'B. Un número decimal menor que 1.', isCorrect: false),
        const Option(
            text:
                'C. Una expresión numérica que muestra la relación entre una parte y el todo.',
            isCorrect: true),
        const Option(
            text:
                'D. Un número irracional que no se puede expresar como una fracción.',
            isCorrect: false)
      ]),
];

final questionsIng = [
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text:
        "1. ¿Cuál de las siguientes opciones describe mejor el propósito principal de un sustantivo en inglés? ",
    options: [
      const Option(
          text: 'A. Expresar emociones o sentimientos.', isCorrect: false),
      const Option(
          text: 'B. Identificar una persona, lugar o cosa.', isCorrect: false),
      const Option(text: 'C.  Indicar la cantidad de algo.', isCorrect: true),
      const Option(text: 'D. Describir una acción.', isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuál de las siguientes opciones muestra la forma correcta del verbo en pasado simple del verbo 'to eat' (comer)?",
      options: [
        const Option(text: 'A. eated', isCorrect: false),
        const Option(text: 'B. ate', isCorrect: true),
        const Option(text: 'C. eatten', isCorrect: false),
        const Option(text: 'D. eaten', isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuál de las siguientes opciones describe mejor el uso del presente continuo (present continuous) en inglés?",
      options: [
        const Option(
            text: 'A. Expresar acciones habituales.', isCorrect: false),
        const Option(
            text: 'B. Indicar una acción que ocurrió en el pasado.',
            isCorrect: false),
        const Option(
            text: 'C. Describir una acción en progreso en el momento presente.',
            isCorrect: true),
        const Option(
            text: 'D.  Expresar una acción futura planeada.', isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál de las siguientes opciones muestra el orden correcto de las palabras en una oración afirmativa en inglés?',
      options: [
        const Option(text: 'A. Verbo - Sujeto - Objeto', isCorrect: false),
        const Option(text: 'B. Objeto - Sujeto - Verbo', isCorrect: false),
        const Option(text: 'C. Sujeto - Verbo - Objeto', isCorrect: true),
        const Option(text: 'D. Sujeto - Objeto - Verbo', isCorrect: false)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Cuál de las siguientes opciones describe mejor el significado del adjetivo 'beautiful' en español?",
      options: [
        const Option(text: 'A. Feo/a', isCorrect: false),
        const Option(text: 'B. Bonito/a', isCorrect: true),
        const Option(text: 'C. Rápido/a', isCorrect: false),
        const Option(text: 'D. Grande', isCorrect: false)
      ]),
];

final questionsNat = [
  //Pregunta 1
  Question(
    text:
        "1. ¿Cuál de las siguientes opciones describe mejor el método científico? ",
    options: [
      const Option(
          text:
              'A. Un conjunto de reglas y procedimientos para resolver problemas matemáticos.',
          isCorrect: false),
      const Option(
          text:
              'B. Un proceso sistemático utilizado para obtener conocimiento y comprender el mundo natural.',
          isCorrect: true),
      const Option(
          text:
              'C. Un conjunto de normas éticas para la conducta de los científicos.',
          isCorrect: false),
      const Option(
          text:
              'D. Un método exclusivo de investigación utilizado solo en ciencias sociales.',
          isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuál de las siguientes unidades se utiliza comúnmente para medir la masa? ",
      options: [
        const Option(text: 'A. Litros.', isCorrect: false),
        const Option(text: 'B. Voltios.', isCorrect: false),
        const Option(text: 'C. Kilogramos.', isCorrect: true),
        const Option(text: 'D. Metros.', isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuál de las siguientes opciones describe mejor la diferencia entre un elemento y un compuesto químico?",
      options: [
        const Option(
            text:
                'A. Un elemento está formado por átomos del mismo tipo, mientras que un compuesto está formado por átomos de diferentes tipos.',
            isCorrect: true),
        const Option(
            text:
                'B. Un elemento es una sustancia pura, mientras que un compuesto es una mezcla homogénea.',
            isCorrect: false),
        const Option(
            text:
                'C. Un elemento no puede descomponerse en sustancias más simples, mientras que un compuesto sí puede.',
            isCorrect: false),
        const Option(
            text:
                'D. Un elemento solo se encuentra en estado gaseoso, mientras que un compuesto puede encontrarse en estado sólido, líquido o gaseoso.',
            isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál de las siguientes opciones describe mejor la función del sistema respiratorio humano?',
      options: [
        const Option(
            text: 'A. Eliminar desechos y toxinas del cuerpo.',
            isCorrect: false),
        const Option(
            text: 'B. Regular la temperatura corporal..', isCorrect: false),
        const Option(
            text:
                'C. Transportar oxígeno hacia las células y eliminar dióxido de carbono.',
            isCorrect: true),
        const Option(
            text: 'D. Producir y liberar hormonas en el torrente sanguíneo.',
            isCorrect: false)
      ]),

  //Pregunta 5
  Question(
      text:
          "5. ¿Cuál de las siguientes opciones describe mejor una característica de los seres vivos?",
      options: [
        const Option(
            text: 'A. Están compuestos únicamente por células procariotas.',
            isCorrect: false),
        const Option(
            text: 'B. No tienen capacidad de reproducirse.', isCorrect: false),
        const Option(
            text:
                'C. Responden a estímulos del entorno y se adaptan a cambios en el medio ambiente.',
            isCorrect: true),
        const Option(
            text:
                'D. No necesitan energía para llevar a cabo sus funciones vitales.',
            isCorrect: false)
      ]),
];

final questionsLec = [
  //Pregunta 1
  Question(
    text:
        "1. ¿Cuál de las siguientes afirmaciones describe mejor una estrategia efectiva para mejorar la comprensión lectora? ",
    options: [
      const Option(
          text: 'A. Leer rápidamente sin prestar atención a los detalles.',
          isCorrect: false),
      const Option(
          text: 'B. Subrayar o resaltar las ideas principales del texto.',
          isCorrect: true),
      const Option(
          text: 'C. Saltar párrafos y leer solo los títulos.',
          isCorrect: false),
      const Option(
          text: 'D. Evitar la lectura de textos extensos.', isCorrect: false)
    ],
  ),

  //Pregunta 2
  Question(
      text:
          "2. ¿Cuál de las siguientes características NO es esencial para la comprensión lectora?",
      options: [
        const Option(text: 'A. Vocabulario amplio.', isCorrect: false),
        const Option(
            text: 'B. Conocimientos previos sobre el tema.', isCorrect: false),
        const Option(
            text: 'C. Habilidades matemáticas avanzadas.', isCorrect: true),
        const Option(
            text:
                'D. Habilidad para identificar la idea principal de un texto.',
            isCorrect: false)
      ]),

  //Pregunta 3
  Question(
      text:
          "3. ¿Cuál de las siguientes opciones describe mejor la idea principal de un texto?",
      options: [
        const Option(
            text: 'A. Un resumen de cada párrafo del texto.', isCorrect: false),
        const Option(
            text: 'B. La primera oración del texto.', isCorrect: false),
        const Option(
            text: 'C. La información más relevante y general del texto.',
            isCorrect: true),
        const Option(
            text: 'D. La opinión del autor sobre el tema.', isCorrect: false)
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál de las siguientes estrategias NO es útil para inferir el significado de una palabra desconocida?',
      options: [
        const Option(
            text: 'A. Leer el contexto en el que se encuentra la palabra.',
            isCorrect: false),
        const Option(
            text: 'B. Buscar la palabra en un diccionario.', isCorrect: false),
        const Option(
            text: 'C. Adivinar el significado sin tener en cuenta el contexto.',
            isCorrect: true),
        const Option(
            text: 'D. Identificar prefijos o sufijos conocidos en la palabra.',
            isCorrect: false)
      ]),

  //Pregunta 5
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
      ]),
];

final questionsSoc = [
  //Pregunta 1
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

  //Pregunta 2
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
      ]),

  //Pregunta 3
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
      ]),

  //Pregunta 4
  Question(
      text:
          '4. ¿Cuál de los siguientes valores NO es fundamental en el desarrollo de competencias ciudadanas?',
      options: [
        const Option(
            text: 'A. Tolerancia hacia la diversidad.', isCorrect: false),
        const Option(
            text: 'B. Solidaridad con los menos favorecidos.',
            isCorrect: false),
        const Option(
            text: 'C. Deshonestidad y falta de ética.', isCorrect: true),
        const Option(
            text: 'D. Respeto por los derechos humanos.', isCorrect: false)
      ]),

  //Pregunta 5
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
            text:
                'C. Promueve la armonía y el respeto mutuo entre las personas.',
            isCorrect: true),
        const Option(
            text: 'D. Excluye a los grupos minoritarios de la sociedad.',
            isCorrect: false)
      ]),
];

Future<void> _guardarPuntajeNivel1(int score) async {
  final user = FirebaseAuth.instance.currentUser;
  final puntaje = score; // Puntaje obtenido

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
        .collection('nivel5')
        .doc(user!.uid);

    await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
  }

  if (_modulo == 'Inglés') {
    //establece el puntaje obtenido y lo guarda en shp
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.setInt('puntaje_ing_1', score);

    final puntajesRefIng = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel5')
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
        .collection('nivel5')
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
        .collection('nivel5')
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
        .collection('nivel5')
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
