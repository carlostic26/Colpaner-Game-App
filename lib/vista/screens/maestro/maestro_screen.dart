import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import '../../../model/user_model.dart';

class Maestro_Screen extends StatefulWidget {
  const Maestro_Screen({Key? key}) : super(key: key);

  @override
  State<Maestro_Screen> createState() => _Maestro_ScreenState();
}

class _Maestro_ScreenState extends State<Maestro_Screen> {
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

  final List<Color?> colors = [
    const Color.fromARGB(255, 2, 59, 64),
    const Color.fromARGB(255, 31, 126, 135),
  ].toList();

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

    getMejoresPuntajesGlobal().then((lista) {
      setState(() {
        mejoresPuntajesGlobal = lista;
      });
    });

    getMejoresPuntajesRazonamiento().then((lista) {
      setState(() {
        mejoresPuntajesMat = lista;
      });
    });

    getMejoresPuntajesLectura().then((lista) {
      setState(() {
        mejoresPuntajesLec = lista;
      });
    });

    getMejoresPuntajesIngles().then((lista) {
      setState(() {
        mejoresPuntajesIng = lista;
      });
    });

    getMejoresPuntajesNaturales().then((lista) {
      setState(() {
        mejoresPuntajesNat = lista;
      });
    });

    getMejoresPuntajesCiudadanas().then((lista) {
      setState(() {
        mejoresPuntajesCiu = lista;
      });
    });


  }

  Future<List<QueryDocumentSnapshot>> getMejoresPuntajesGlobal() async {
    final puntajesRef = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRef
        .doc('podio')
        .collection('global')
        .orderBy('puntajeGlobal', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajes = querySnapshot.docs;
    print('final mejoresPuntajes = querySnapshot.docs: $mejoresPuntajes');

    return mejoresPuntajes;
  }

  Future<List<QueryDocumentSnapshot>> getMejoresPuntajesRazonamiento() async {
    final puntajesRefMat = FirebaseFirestore.instance.collection('puntajes');

    final querySnapshot = await puntajesRefMat
        .doc('podio')
        .collection('Razonamiento Cuantitativo')
        .orderBy('puntajeModulo', descending: true)
        .limit(50)
        .get();

    final mejoresPuntajesMat = querySnapshot.docs;
    print('final mejoresPuntajesMat = querySnapshot.docs: $mejoresPuntajesMat');

    return mejoresPuntajesMat;
  }

  Future<List<QueryDocumentSnapshot>>  getMejoresPuntajesLectura() async {
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

  Future<List<QueryDocumentSnapshot>>  getMejoresPuntajesIngles() async {
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

  Future<List<QueryDocumentSnapshot>> getMejoresPuntajesNaturales() async {
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

  Future<List<QueryDocumentSnapshot>> getMejoresPuntajesCiudadanas() async {
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Maestro_Screen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        children: List.generate( mejoresPuntajesGlobal.length,
                            (index) {
                          final documento = mejoresPuntajesGlobal[index];
                          final datos = documento.data();
                          final datosMap = datos as Map<String, dynamic>?;
                          final name = datosMap?['fullName'] as String?;
                          final userId = datosMap?['userId'] as String?;
                          final puntaje = datosMap?['puntajeGlobal'] as int?;
                          final tecnica = datosMap?['tecnica'] as String?;
                          var avatar = datosMap?['avatar'] as String?;

                          avatar ??= '';

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: 40,
                            color: colors[index % 2],
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 1, 0),
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
                                        const EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    child: Row(
                                      //aqui iria el avatar del usuario string a cached image netowrk
                                      children: [
                                        CachedNetworkImage(
                                          color: colors_colpaner.oscuro,
                                          width: 35,
                                          height: 35,
                                          fadeInDuration: Duration.zero,
                                          imageUrl: avatar,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$name',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro),
                                      ),
                                      Text(
                                        '$tecnica',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
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
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),

                                          Text(
                                            '$puntaje',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
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

          ],
        ),
      ),
    );
  }
}
