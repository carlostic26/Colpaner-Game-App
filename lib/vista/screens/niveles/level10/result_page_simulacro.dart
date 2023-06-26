part of simulacro;

class ResultPageSimulacro extends StatefulWidget {
  const ResultPageSimulacro({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  _ResultPageSimulacroState createState() => _ResultPageSimulacroState();
}

class _ResultPageSimulacroState extends State<ResultPageSimulacro> {
  String _modulo = '';

  @override
  void initState() {
    super.initState();
    _getModuloFromSharedPrefs();
  }

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
          body: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Text(
                  _modulo,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'BubblegumSans',
                      fontSize: 30),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
                  child: Column(children: [
                    //Celda cabecera: pregunta ABCBD
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                              child: Text(
                                'Pregunta',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                              child: Text(
                                'A',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                              child: Text(
                                'B',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                              child: Text(
                                'C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                              child: Text(
                                'D',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        )),

                    //1
                    Container(
                        height: 40,
                        color: Colors.white,
                        child: Row(children: [
                          //pregunta
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.20,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                'Pregunta numero uno donde se presenta un analisis al estudiante.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 10),
                              ),
                            ),
                          ),

                          //Respuestas en formato punto color, al tocarlos se abre dialogo con el enunciado de la respuesta
                          Expanded(
                            child: Row(
                              children: [
                                //Respuesta A
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(1, 0, 35, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('A'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cerrar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //Respuesta B
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 35, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('B'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cerrar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //Respuesta C
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 35, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('C'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cerrar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //Respuesta D
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('D'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    //2
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    //3
                    Container(height: 40, color: Colors.white, child: Row()),
                    //4
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    //5
                    Container(height: 40, color: Colors.white, child: Row()),
                    //6
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    Container(height: 40, color: Colors.white, child: Row()),
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    Container(height: 40, color: Colors.white, child: Row()),
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    Container(height: 40, color: Colors.white, child: Row()),
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    Container(height: 40, color: Colors.white, child: Row()),
                    Container(
                        height: 40,
                        color: colors_colpaner.oscuro,
                        child: Row()),
                    Container(height: 40, color: Colors.white, child: Row()),
                  ]),
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
