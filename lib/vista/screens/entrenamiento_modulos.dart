import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/drawer.dart';
import 'package:gamicolpaner/vista/screens/helpers/helpers.dart';
import 'package:gamicolpaner/vista/screens/helpers/helpers.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class entrenamientoModulos extends StatefulWidget {
  const entrenamientoModulos({super.key});

  @override
  State<entrenamientoModulos> createState() => _entrenamientoModulosState();
}

// ignore: camel_case_types
class _entrenamientoModulosState extends State<entrenamientoModulos> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  LocalStorage localStorage = LocalStorage();
  String _imageAvatarUrl = '';
  late bool permitirAcceso;

  Future<void> verificarHorarioPermitido() async {
    // en este momento está ajustado para ingreso de cualquier dia a cualquier hora
    // para sacar a produccion es necesario cambiar hora a horaInicio: 8am horaFin: 10am
    // y ajustar Datetime a     final esDiaHabil = (diaSemana >= DateTime.monday && diaSemana <= DateTime.friday);
    final horaActual = DateTime.now();
    final horaInicio =
        DateTime(horaActual.year, horaActual.month, horaActual.day, 7);
    var horaFin =
        DateTime(horaActual.year, horaActual.month, horaActual.day, 10);

    final horaActualColombia = horaActual.toLocal();

    if (horaFin.isBefore(horaInicio)) {
      horaFin = horaFin.add(Duration(days: 1));
    }

    final diaSemana = horaActualColombia.weekday;
    //final diaSemana = 6;
    final esDiaHabil = //de lunes a miercoles, y solo viernes
        (diaSemana >= DateTime.monday &&
            diaSemana <=
                DateTime
                    .friday); //(diaSemana >= DateTime.monday && diaSemana <= DateTime.wednesday || diaSemana == DateTime.friday);

    if (esDiaHabil &&
        horaActualColombia.isAfter(horaInicio) &&
        horaActualColombia.isBefore(horaFin)) {
      setState(() {
        permitirAcceso = true;
      });
    } else {
      setState(() {
        permitirAcceso = true;
      });
    }

    print('horaActual: $horaActual');
    print('horaInicio: $horaInicio');
    print('horaFinal: $horaFin');
    print('diaActual: $diaSemana');
    print('diaHabil: $esDiaHabil');
  }

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageAvatarUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEhdORwcTSZjwjYlKKyHakRAdfe2U9tUKiF6QFqoFUDQ1Uci0fjQjCDHZMSorYBSFsB8XN0IkZM7iabV62RQzR6vtQg3cq2a43SNRQp-CX7LGt44G9VjOxukTofGIlmQUv116qwJMcYEzmwlQxznG7B2oJFU0SIRTot_jCDk6TVvoCkoXlSziXWY_ps';
    });
  }

  bool isAvatar = false;

  Future<bool> getIsAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    isAvatar = prefs.getBool('isAvatar') ?? false;
    setState(() {
      this.isAvatar = isAvatar;
    });
    return isAvatar;
  }

  String gender = '';

  Future<String> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    String gender = prefs.getString('gender') ?? 'none';
    setState(() {
      this.gender = gender;
    });
    return gender;
  }

  void sendUserDataShp() {
    String name = loggedInUser.fullName.toString();
    String tecnic = loggedInUser.tecnica.toString();
    String avatar = loggedInUser.avatar.toString();
    String email = loggedInUser.email.toString();

    Fluttertoast.showToast(
      msg: " sendDataUserShp: $name , $tecnic", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.CENTER, // location
    );

    //escribo info en shared preferences para ahorrar lecturas a firebase
    localStorage.setDataUser(name, email, tecnic, avatar);
  }

  String name = '';
  String tecnic = '';
  String avatar = '';
  String email = '';

  bool isConnected = false;
  HelperClass helpers = HelperClass();
  @override
  void initState() {
    getIsAvatar();
    getGender();
    _getAvatarFromSharedPrefs();
    verificarHorarioPermitido();
    checkInternet();
    print('permitirAcceso: $permitirAcceso');
    getUser();

    super.initState();
  }

  void getUser() async {
    String actualUser = await localStorage.getActualUser();

    //si contiene usuario, no vuelve a leer user de firebase
    if (actualUser == '') {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());

        setState(() {
          name = loggedInUser.fullName.toString();
          tecnic = loggedInUser.tecnica.toString();
          avatar = loggedInUser.avatar.toString();
          email = loggedInUser.email.toString();

          localStorage.setDataUser(name, email, tecnic, avatar);
          localStorage.setActualUser(name);
        });

        /* Fluttertoast.showToast(msg: 'datos guardados: $name , $tecnic'); */
      });
    } else {
      //Fluttertoast.showToast(msg: 'no entró a guardar datos: $actualUser');
    }
  }

  String imageUrlMat =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgklsdnuPrrdBpPYXszCk0ylHlrudUYh9sfOQuClYW6Cuuio7cyUsf7FjGKLOUrhkhPH6JU6-q1rOy4_dBvw4agt3xhv7xbdBLW5bq2e31z7bChNIOplMECDNxQ7QgIF5UuktiAS21VVWJuNfj77gjkTDe0ADdoTCq1Rq_FQw6-epK6J6_jxGSH5PaLZg/s320/razonamiento.png';
  String imageUrlIng =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg_7XMXp58fZ2Kz3zuVLL9hplJF_Ee-TfTkrkFkRVVwxw4v-GNMJzzw3yr-O6exbC9F0eNx_1Py7ZFV0G7fU2bZk-AH3QtTZdemVhQwPzwQXp8Hcf_scyZXsLYCberqUG2knQbyuwuJ4PijSQ8Ws8vL9z-hzqpMs-KcS_nTij8x2Rkms2s12slahR7V_w/s320/ingles.png';
  String imageUrlLect =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiufePmroXAJRWSeaBnAqq3OBOgt02_VNnrHY5lN0bdZGB7OqybxS9rjuRbKvzRGDLO1q5zM8ev8FBBaLPv0F1Ge9G6guiZI5KGcSbOjQ3AV1xGU9CSH1tiumDXduRUv5fq54ooTz05bknDb2QdrvnuKFHway_WAOTfLGPUC53fDoNA8pqOsrUXwRyoLg/s320/lectura.png';
  String imageUrlNatu =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjm9hJOpC4RE6ggvXXMfsRWezt4sANYQkU0AwRdgnfotgYRs9CPGrcsniRuWtDSAR6dP22q1kmWq20WrP_3Kl62G5fFtmCrrimySskR8aRTiB8KnBFu8Ezs1LqhWGvbXt9OnuhNzHjydOhClYhAjdZ67vGn6lqNkW5YPyFzy62uLGBUX86mr2hTd0iN-Q/s320/naturales.png';
  String imageUrlCiud =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOqgWKHcgRX826WCSVdLVqiExF3ufiHRPoBmgRfCjzgQ1suKTAEp1t6kajiP18rfnMwgp1xwDF2zD24Go237mE34Nqs_nUofFtalxkJjsylXUKiDn7-XwIrmbxHAggMIprIfGU191s2vW6mu5B9oqFu0JioQBiP89yzKjQgGb4hhGwyATwWR_jvjr2NQ/s320/ciudadanas.png';

  Future<void> checkInternet() async {
    isConnected = await helpers.checkInternetConnection();

    setState(() {
      isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay conexión a Internet
    if (!isConnected) {
      return helpers.conectionScaffold(context);
    } else if (permitirAcceso) {
      return Scaffold(
        backgroundColor: colors_colpaner.base,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Entrenamiento",
            style: TextStyle(
              color: colors_colpaner.claro,
              fontSize: 16.0,
              fontFamily: 'BubblegumSans',
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: colors_colpaner.claro),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            //Lectura crítica - Inglés
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          //establece en memoria el módulo controlado por el usuario
                          localStorage.setModulo('Razonamiento Cuantitativo');

                          dialogoAccesModulo(
                              context, 'Razonamiento Cuantitativo');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors_colpaner.oscuro,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrlMat,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "Razonamiento Cuantitativo",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
/*                           //establece en memoria el módulo controlado por el usuario
                          localStorage.setModulo('Lectura Crítica');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const world_game()),
                          );
 */
                          //establece en memoria el módulo controlado por el usuario
                          localStorage.setModulo('Lectura Crítica');

                          dialogoAccesModulo(context, 'Lectura Crítica');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors_colpaner.oscuro,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrlLect,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lectura Crítica",
                                style: TextStyle(
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Inglés - Naturales
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
/*                           localStorage.setModulo('Inglés');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const world_game()),
                          ); */

                          //establece en memoria el módulo controlado por el usuario
                          localStorage.setModulo('Inglés');

                          dialogoAccesModulo(context, 'Inglés');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors_colpaner.oscuro,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrlIng,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Inglés",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'BubblegumSans',
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
/*                           localStorage.setModulo('Ciencias Naturales');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const world_game()),
                          );

                                      */ //establece en memoria el módulo controlado por el usuario
                          localStorage.setModulo('Ciencias Naturales');
                          dialogoAccesModulo(context, 'Ciencias Naturales');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors_colpaner.oscuro,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrlNatu,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      "Ciencias Naturales",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //competencias ciudadanas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          localStorage.setModulo('Competencias Ciudadanas');
/*                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const world_game()),
                          );
 */
                          dialogoAccesModulo(
                              context, 'Competencias Ciudadanas');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors_colpaner.oscuro,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors_colpaner.oscuro,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrlCiud,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Competencias Ciudadanas",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'BubblegumSans',
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            )
          ],
        ),
        drawer: DrawerColpaner(
          context: context,
          screen: 'entrenamiento',
        ),
      );
    } else {
      return helpers.horarioScaffold(context);
    }
  }

// función para eliminar todos los registros de Shared Preferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void dialogoAccesModulo(BuildContext context, String modulo) {
    String pin = '';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 1,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          "Código de acceso\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: "Digita el pin de acceso",
                          ),
                          onChanged: (String value) {
                            setState(() {
                              pin = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          child: const Text("Ingresar"),
                          onPressed: () {
                            if ((pin == 'lc20tr23' &&
                                    modulo == 'Lectura Crítica') ||
                                (pin == 'm20t23s' &&
                                    modulo == 'Razonamiento Cuantitativo') ||
                                (pin == '2n0g2ls3' && modulo == 'Inglés') ||
                                (pin == 'n2t0r2l3s' &&
                                    modulo == 'Ciencias Naturales') ||
                                (pin == 'c2d2dn3s' &&
                                    modulo == 'Competencias Ciudadanas')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const world_game(),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Pin incorrecto",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
