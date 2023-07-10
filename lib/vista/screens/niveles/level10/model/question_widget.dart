part of simulacro;

class QuestionWidget extends StatefulWidget {
  Future<List<question_model>>? questions;

  QuestionWidget({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

//clase que retorna la pregunta en pantalla
class _QuestionWidgetState extends State<QuestionWidget> {
  late List<question_model>? _questions = [];

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
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final questions = await widget.questions;
    setState(() {
      _questions = questions;

      print(
          "imprimir la lista de preguntas _questions:\n $_questions"); // imprimir la lista de preguntas
      print(
          " imprimir la longitud de la lista _questions.length: \n${_questions?.length}"); // imprimir la longitud de la lista
    });
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

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _modulo,
                  style: const TextStyle(
                      color: colors_colpaner.oscuro,
                      fontFamily: 'BubblegumSans',
                      fontSize: 15.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    //TEXTO QUE CONTIENE EL PONDERADO  DE PREGUNTAS
                    'Pregunta $_questionNumber/${_questions?.length}',
                    style: const TextStyle(
                        color: colors_colpaner.oscuro,
                        fontFamily: 'BubblegumSans',
                        fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ],
        ),

        //Se imprime el pageView que contiene pregunta y opciones
        Expanded(
          child: _questions != null
              ? PageView.builder(
                  itemCount: _questions!.length,
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final _questionBuild = _questions![index];
                    return buildQuestion(_questionBuild);
                  })
              : const SizedBox.shrink(),
        ),
        _isLocked
            ? buildElevatedButton(_questions?.length)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Padding buildQuestion(question_model questionBuild) {
    Future<Size>? _imageSize;
    int? imgHeigh;

    Future<Size> _getImageSize() async {
      final Completer<Size> completer = Completer();
      final Image image = Image.network(questionBuild.imagen);
      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          ));
        }),
      );
      return completer.future;
    }

    @override
    didChangeDependencies() {
      _imageSize = _getImageSize();
      imgHeigh = _imageSize.toString() as int?;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //altura del cuerpo que contiene pregunta y respuestas
          const SizedBox(height: 15),
          SizedBox(
            //MediaQuery.of(context).size.height * 0.50,
            height: (questionBuild.pregunta.length > 1 &&
                    questionBuild.pregunta.length <= 101 &&
                    questionBuild.imagen == '') //2 lineas
                ? 90
                : (questionBuild.pregunta.length > 1 &&
                        questionBuild.pregunta.length <= 101 &&
                        questionBuild.imagen != '') //2 lineas
                    ? 430
                    :
                    //
                    questionBuild.pregunta.length >= 102 &&
                            questionBuild.pregunta.length <= 150 &&
                            questionBuild.imagen == '' //4 lineas
                        ? 140
                        : questionBuild.pregunta.length >= 102 &&
                                questionBuild.pregunta.length <= 150 &&
                                questionBuild.imagen != '' //4 lineas
                            ? 450
                            :
                            //
                            questionBuild.pregunta.length >= 141 &&
                                    questionBuild.pregunta.length <=
                                        158 && //6 lineas o mas
                                    questionBuild.imagen == ''
                                ? 140
                                : questionBuild.pregunta.length >= 141 &&
                                        questionBuild.pregunta.length <=
                                            200 && //6 lineas o mas
                                        questionBuild.imagen != '' //4 lineas
                                    ? 450
                                    : questionBuild.pregunta.length >= 159 &&
                                            questionBuild.pregunta.length <=
                                                200 && //6 lineas o mas
                                            questionBuild.imagen != ''
                                        ? 450
                                        : questionBuild.pregunta.length >=
                                                    159 &&
                                                questionBuild.pregunta.length <=
                                                    200 && //6 lineas o mas
                                                questionBuild.imagen ==
                                                    '' //4 lineas
                                            ? 155
                                            :
                                            //
                                            questionBuild.pregunta.length >=
                                                        1000 && // texto largo
                                                    questionBuild.imagen == ''
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.45
                                                : questionBuild.pregunta
                                                                .length >=
                                                            1000 && // texto largo
                                                        questionBuild.imagen !=
                                                            '' //4 lineas
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.40
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.45,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      questionBuild
                          .pregunta, //questionBuild.pregunta.length.toString() +questionBuild.pregunta,
                      style: const TextStyle(
                        color: colors_colpaner.claro,
                        fontFamily: 'BubblegumSans',
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (questionBuild.imagen != '')
                      InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 5.0,
                        boundaryMargin: const EdgeInsets.all(100),
                        panEnabled: true,
                        scaleEnabled: true,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: imgHeigh?.toDouble(),
                          child: Image.network(
                            questionBuild.imagen,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                  ],
                )),
          ),

          const SizedBox(height: 5),
          Expanded(
              child: OptionsWidget(
            question: questionBuild,
            onClickedOption: (option) {
              if (questionBuild.isLocked) {
                return;
              } else {
                setState(() {
                  questionBuild.isLocked = true;
                  questionBuild.selectedOption = option;
                });
                _isLocked = questionBuild.isLocked;
                if (questionBuild.selectedOption!.isCorrect) {
                  _score++;
                }
              }
            },
          ))
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton(int? questionsLength) {
    return ElevatedButton(
      onPressed: () async {
        if (_questionNumber < questionsLength) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          gameOver10(_score);
/*           Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(score: _score),
            ),
          ); */

          await _guardarPuntaje(
              _score); // Llamar a la función para guardar el puntaje
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors_colpaner.claro, // Background color
        minimumSize: const Size(100, 35),
      ),
      child: Text(
        _questionNumber < questionsLength! ? 'Siguiente' : 'Revisar resultado',
        style: const TextStyle(
            color: colors_colpaner.oscuro,
            fontFamily: 'BubblegumSans',
            fontSize: 25.0),
      ),
    );
  }

  Future<void> gameOver10(int score) async {
    //muetra pantalla de resultados que pide un pin de acceso que lo dará cada profesor
    //DialogHelper.showDialogGameOver(context, score);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String pin = '';
        return AlertDialog(
          title: const Center(child: Text('Código de acceso')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(height: 5.0),
                const Text(
                  '* Se requiere un pin de 5 dígitos para revisar los resultados. Si eres estudiante pregúntale al maestro encargado.',
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Digita el pin',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      pin = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Center(child: Text('Ingresar')),
              onPressed: () {
                if (pin == '00000') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ResultPageSimulacro(score: score)),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Pin incorrecto',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _guardarPuntaje(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    final puntaje = score; // Puntaje obtenido
    LocalStorage localStorage = LocalStorage();

//obtiene el modulo del shp
    String _modulo = await localStorage.getModulo();

    if (_modulo == 'Razonamiento Cuantitativo') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreMat10(score);

      final puntajesRefMat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('matematicas')
          .collection('nivel10')
          .doc(user!.uid);

      await puntajesRefMat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Inglés') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreIng10(score);

      final puntajesRefIng = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ingles')
          .collection('nivel10')
          .doc(user!.uid);

      await puntajesRefIng.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Lectura Crítica') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreLec10(score);

      final puntajesRefLec = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('lectura')
          .collection('nivel10')
          .doc(user!.uid);

      await puntajesRefLec.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Ciencias Naturales') {
      //save score in shared preferente to save resources at firebase
      localStorage.setScoreNat10(score);

      final puntajesRefNat = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('naturales')
          .collection('nivel10')
          .doc(user!.uid);

      await puntajesRefNat.set({'userId': user.uid, 'puntaje': puntaje});
    }

    if (_modulo == 'Competencias Ciudadanas') {
      final puntajesRefSoc = FirebaseFirestore.instance
          .collection('puntajes')
          .doc('ciudadanas')
          .collection('nivel10')
          .doc(user!.uid);

      await puntajesRefSoc.set({'userId': user.uid, 'puntaje': puntaje});
    }
  }
}
