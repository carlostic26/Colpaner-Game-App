import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:connectivity/connectivity.dart';

class HelperClass {
  Widget horarioScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gif_fondo.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85), // Ajusta la opacidad aquí
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiObUamKYL3kEUaqztoQq3GS5BN4reaPkHEmewms-2W6D5rNCvgZayv-dwYPPpcdTTe3U6uxpPb0si2PH28gAjqaBVP75jwuolg_XXaHWuR_-1xg-vkaCK0U9Ep5MLpKJXNPDPx8A2p5peo7H64pf8nZFg2lnD9WwEFeFtB5u_K5qXCuqrXav6dPEnKBA/s320/logo%20colpaner%20game%20app%20png.png',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  // Ajusta el ancho y alto de la imagen según tus necesidades
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ADVERTENCIA',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30.0,
                      fontFamily: 'BubblegumSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No puedes acceder a la app de entrenamiento ICFES Saber 11 de Colpaner Game App en días y horarios no autorizados.',
                    style: TextStyle(
                      color: colors_colpaner.claro,
                      fontSize: 16.0,
                      fontFamily: 'BubblegumSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget conectionScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gif_fondo.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85), // Ajusta la opacidad aquí
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiObUamKYL3kEUaqztoQq3GS5BN4reaPkHEmewms-2W6D5rNCvgZayv-dwYPPpcdTTe3U6uxpPb0si2PH28gAjqaBVP75jwuolg_XXaHWuR_-1xg-vkaCK0U9Ep5MLpKJXNPDPx8A2p5peo7H64pf8nZFg2lnD9WwEFeFtB5u_K5qXCuqrXav6dPEnKBA/s320/logo%20colpaner%20game%20app%20png.png',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  // Ajusta el ancho y alto de la imagen según tus necesidades
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ADVERTENCIA',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30.0,
                      fontFamily: 'BubblegumSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No puedes acceder a la app de entrenamiento ICFES Saber 11 de Colpaner Game App sin una conexión a internet.\n\nPásate a Wifi o datos móviles.',
                        style: TextStyle(
                          color: colors_colpaner.claro,
                          fontSize: 16.0,
                          fontFamily: 'BubblegumSans',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const entrenamientoModulos()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Ajusta el valor según tus necesidades
                        ),
                        primary: colors_colpaner
                            .oscuro, // Ajusta el color de fondo según tus necesidades
                        padding: const EdgeInsets.all(13.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.refresh,
                            color: colors_colpaner
                                .claro, // Ajusta el color del icono según tus necesidades
                          ),
                          SizedBox(
                              width:
                                  8.0), // Ajusta el espacio entre el icono y el texto según tus necesidades
                          Text(
                            'Reintentar',
                            style: TextStyle(
                              color: Colors
                                  .white, // Ajusta el color del texto según tus necesidades
                              fontSize: 16.0,
                              fontFamily: 'BubblegumSans',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No hay conexión a Internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }
    return true;
  }
}
