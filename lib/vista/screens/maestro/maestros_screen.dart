import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/services/local_storage.dart';
import '../../../model/user_model.dart';

class MaestroScreen extends StatefulWidget {
  const MaestroScreen({Key? key}) : super(key: key);

  @override
  State<MaestroScreen> createState() => _MaestroScreenState();
}

class _MaestroScreenState extends State<MaestroScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late List<QueryDocumentSnapshot> mejoresPuntajesGlobal =
  []; // Inicializar la variable con una lista vacía

  late List<QueryDocumentSnapshot> mejoresPuntajesMat =
  []; // Inicializar la variable con una lista vacía

  late List<QueryDocumentSnapshot> mejoresPuntajesLec =
  []; // Inicializar la variable con una lista vacía

  late List<QueryDocumentSnapshot> mejoresPuntajesIng =
  []; // Inicializar la variable con una lista vacía

  late List<QueryDocumentSnapshot> mejoresPuntajesNat =
  []; // Inicializar la variable con una lista vacía

  late List<QueryDocumentSnapshot> mejoresPuntajesCiu =
  []; // Inicializar la variable con una lista vacía


  LocalStorage localStorage = LocalStorage();
  late SharedPreferences prefs;
  String _modulo='';

  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });

    obtenerMejoresPuntajesGlobal().then((lista) {
      setState(() {
        mejoresPuntajesGlobal = lista;
      });
    });

    obtenerMejoresPuntajesRazonamiento().then((lista) {
      setState(() {
        mejoresPuntajesMat = lista;
      });
    });

    obtenerMejoresPuntajesLectura().then((lista) {
      setState(() {
        mejoresPuntajesLec = lista;
      });
    });

    obtenerMejoresPuntajesIngles().then((lista) {
      setState(() {
        mejoresPuntajesIng = lista;
      });
    });

    obtenerMejoresPuntajesNaturales().then((lista) {
      setState(() {
        mejoresPuntajesNat = lista;
      });
    });

    obtenerMejoresPuntajesCiudadanas().then((lista) {
      setState(() {
        mejoresPuntajesCiu = lista;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<List<QueryDocumentSnapshot>> obtenerMejoresPuntajesGlobal() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('global')
        .orderBy('puntajeGlobal', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajes = querySnapshot.docs;

    return mejoresPuntajes;
  }

  Future<List<QueryDocumentSnapshot>> obtenerMejoresPuntajesRazonamiento() async {
    final puntajesRefMat = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRefMat
        .doc('podio')
        .collection('Razonamiento Cuantitativo')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajesMat = querySnapshot.docs;

    return mejoresPuntajesMat;
  }

  Future<List<QueryDocumentSnapshot>>  obtenerMejoresPuntajesLectura() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('Lectura Crítica')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajes = querySnapshot.docs;

    return mejoresPuntajes;
  }

  Future<List<QueryDocumentSnapshot>>  obtenerMejoresPuntajesIngles() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('Inglés')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajesIng = querySnapshot.docs;

    return mejoresPuntajesIng;
  }

  Future<List<QueryDocumentSnapshot>> obtenerMejoresPuntajesNaturales() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('Ciencias Naturales')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajesNat = querySnapshot.docs;

    return mejoresPuntajesNat;
  }

  Future<List<QueryDocumentSnapshot>> obtenerMejoresPuntajesCiudadanas() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('Competencias Ciudadanas')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajesCiu = querySnapshot.docs;

    return mejoresPuntajesCiu;
  }

  final List<Color?> colors = [
    const Color.fromARGB(255, 2, 59, 64),
    const Color.fromARGB(255, 31, 126, 135),
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors_colpaner.base,
        appBar: AppBar(
          backgroundColor:
          Colors.transparent, // establece el color de fondo transparente
          elevation: 0, // elimina la sombra
          iconTheme: const IconThemeData(
              color: colors_colpaner
                  .claro), // cambia el color del icono del botón de menú lateral a negro
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                //Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MaestroScreen()));
              },
            ),
          ],
        ),

        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: CachedNetworkImage(
              imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiqOeTnxkinXDP3WNpbUiLOf1bKls6UEgeyzOKZAdnIoHE3kELwBftPnhD5V9sUMOlRdihzdAg3lF4RG80O1w-s1kxFM7JmLcH-gwWcZ-KfyZKizoxAxmoX208UmPoCEfkfnbkkBObsCMbcC2QlzCC_Ch6Z58tLdvrtmKvBu8QKZAsaCh2dqseCCfQ/s320/1200px-Mano_cursor.svg.png',
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child:Column(
              children: [
                //general
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "General",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesGlobal.length, (index) {
                              final documento = mejoresPuntajesGlobal[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeGlobal'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),


                //ingles
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Inglés",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesIng.length, (index) {
                              final documento = mejoresPuntajesIng[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeModulo'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                //naturales
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Naturales",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesNat.length, (index) {
                              final documento = mejoresPuntajesNat[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeModulo'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                //ciudadanas
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Competencias Ciudadanas",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesCiu.length, (index) {
                              final documento = mejoresPuntajesCiu[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeModulo'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //razonamiento
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Razonamiento Cuantitativo",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesMat.length, (index) {
                              final documento = mejoresPuntajesMat[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeModulo'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                //lectura
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      "Lectura Crítica",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                                mejoresPuntajesLec.length, (index) {
                              final documento = mejoresPuntajesLec[index];
                              final datos = documento.data();
                              final datosMap =
                              datos as Map<String, dynamic>?;
                              final name =
                              datosMap?['fullName'] as String?;
                              final userId =
                              datosMap?['userId'] as String?;
                              final puntaje =
                              datosMap?['puntajeModulo'] as int?;
                              final tecnica =
                              datosMap?['tecnica'] as String?;
                              var avatar = datosMap?['avatar'] as String?;

                              avatar ??= '';

                              return Container(
                                width: MediaQuery.of(context).size.width *
                                    0.95,
                                height: 40,
                                color: colors[index % 2],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 1, 0),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Row(
                                          //aqui iria el avatar del usuario string a cached image netowrk
                                          children: [
                                            CachedNetworkImage(
                                              color:
                                              colors_colpaner.oscuro,
                                              width: 35,
                                              height: 35,
                                              fadeInDuration:
                                              Duration.zero,
                                              imageUrl: avatar,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context,
                                                  url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$name',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: colors_colpaner
                                                    .claro),
                                          ),
                                          Text(
                                            '$tecnica',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              10, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              //medalla
                                              Text(
                                                (index == 0)
                                                    ? '🥇'
                                                    : (index == 1)
                                                    ? '🥈'
                                                    : (index == 2)
                                                    ? '🥉'
                                                    : '🎖️',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),

                                              Text(
                                                '$puntaje',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

              ],
            ),),
        ]));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
