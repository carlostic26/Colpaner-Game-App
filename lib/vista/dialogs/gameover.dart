import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Este archivo dart contiene todas las clases tipo dialogo GAME OVER
class ShowDialogGameOver extends StatefulWidget {
  ShowDialogGameOver({required this.score});

  late int score;

  @override
  State<ShowDialogGameOver> createState() => _ShowDialogGameOver();
}

class _ShowDialogGameOver extends State<ShowDialogGameOver> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      backgroundColor: colors_colpaner.base,
      child: _buildChild(context),
    );
  }

  String _modulo = '';

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  _buildChild(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                //titulo del nivel
                "🥳 Gaminivel Termidado 🕑",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BubblegumSans',
                    fontSize: 25.0),
              ),
              const SizedBox(height: 20),

              //celda del medio: img y puntaje
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://i.pinimg.com/originals/91/8b/df/918bdf201dc850502d876c0481e5eb84.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Has obtenido: ",
                                    style: TextStyle(
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 20,
                                        color: colors_colpaner.claro)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          // se muestra el score en String
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "+" + widget.score.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 50,
                                        color: colors_colpaner.claro)),
                              ],
                            ),
                          ),

                          FutureBuilder<int>(
                            future: _modulo == 'Razonamiento Cuantitativo'
                                ? getPuntajesTotal_MAT()
                                : _modulo == 'Inglés'
                                    ? getPuntajesTotal_ING()
                                    : _modulo == 'Lectura Crítica'
                                        ? getPuntajesTotal_LEC()
                                        : _modulo == 'Competencias Ciudadanas'
                                            ? getPuntajesTotal_CIU()
                                            : _modulo == 'Ciencias Naturales'
                                                ? getPuntajesTotal_NAT()
                                                : getPuntajesTotal_NAT(),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'Acumulado: ${snapshot.data} + ${widget.score}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 12,
                                  ),
                                );
                              } else {
                                return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child:
                                        CircularProgressIndicator()); // O cualquier otro indicador de carga
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Center(
                  child: Row(
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
                          Navigator.pop(context);
                          Navigator.pop(context);
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
                ),
              ),
            ],
          ),
        ),
      );
}
