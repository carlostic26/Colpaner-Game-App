import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/drawer.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'auth/login_screen.dart';

class misPuntajes extends StatefulWidget {
  const misPuntajes({super.key});

  @override
  State<misPuntajes> createState() => _misPuntajesState();
}

class _misPuntajesState extends State<misPuntajes> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String _modulo = '';

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  String _imageUrl = '';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';
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

  final List<Color?> colors = [
    const Color.fromARGB(180, 2, 59, 64),
    const Color.fromARGB(180, 209, 252, 207)
  ].toList();

/*   final List<Color?> colors = [
    const Color.fromARGB(255, 2, 59, 64),
    const Color.fromARGB(255, 209, 252, 207),
  ].where((color) => color != null).toList(); */

  int puntos_mat = 0;
  int puntos_ing = 0;
  int puntos_lec = 0;
  int puntos_ciu = 0;
  int puntos_nat = 0;
  int puntos_test = 5;
  final int puntosMaximos_test = 100;

  int mat1 = 0,
      mat2 = 0,
      mat3 = 0,
      mat4 = 0,
      mat5 = 0,
      mat6 = 0,
      mat7 = 0,
      mat8 = 0,
      mat9 = 0,
      mat10 = 0;

  int ing1 = 0,
      ing2 = 0,
      ing3 = 0,
      ing4 = 0,
      ing5 = 0,
      ing6 = 0,
      ing7 = 0,
      ing8 = 0,
      ing9 = 0,
      ing10 = 0;

  int lec1 = 0,
      lec2 = 0,
      lec3 = 0,
      lec4 = 0,
      lec5 = 0,
      lec6 = 0,
      lec7 = 0,
      lec8 = 0,
      lec9 = 0,
      lec10 = 0;

  int ciu1 = 0,
      ciu2 = 0,
      ciu3 = 0,
      ciu4 = 0,
      ciu5 = 0,
      ciu6 = 0,
      ciu7 = 0,
      ciu8 = 0,
      ciu9 = 0,
      ciu10 = 0;

  int nat1 = 0,
      nat2 = 0,
      nat3 = 0,
      nat4 = 0,
      nat5 = 0,
      nat6 = 0,
      nat7 = 0,
      nat8 = 0,
      nat9 = 0,
      nat10 = 0;

//recibe puntajes de shp de world_game enviados a guardar localmente
  Future<void> getPuntaje_MAT() async {
    final prefs = await SharedPreferences.getInstance();

    String score1 = prefs.getString('puntaje_mat_1') ?? '0';
    mat1 = int.parse(score1);

    String score2 = prefs.getString('puntaje_mat_2') ?? '0';
    mat2 = int.parse(score2);

    String score3 = prefs.getString('puntaje_mat_3') ?? '0';
    mat3 = int.parse(score3);

    String score4 = prefs.getString('puntaje_mat_4') ?? '0';
    mat4 = int.parse(score4);

    String score5 = prefs.getString('puntaje_mat_5') ?? '0';
    mat5 = int.parse(score5);

    String score6 = prefs.getString('puntaje_mat_6') ?? '0';
    mat6 = int.parse(score6);

    String score7 = prefs.getString('puntaje_mat_7') ?? '0';
    mat7 = int.parse(score7);

    String score8 = prefs.getString('puntaje_mat_8') ?? '0';
    mat8 = int.parse(score8);

    String score9 = prefs.getString('puntaje_mat_9') ?? '0';
    mat9 = int.parse(score9);

    String score10 = prefs.getString('puntaje_mat_10') ?? '0';
    mat10 = int.parse(score10);
  }

  Future<void> getPuntaje_ING() async {
    final prefs = await SharedPreferences.getInstance();

    String score1 = prefs.getString('puntaje_ingles_1') ?? '0';
    ing1 = int.parse(score1);

    String score2 = prefs.getString('puntaje_ingles_2') ?? '0';
    ing2 = int.parse(score2);

    String score3 = prefs.getString('puntaje_ingles_3') ?? '0';
    ing3 = int.parse(score3);

    String score4 = prefs.getString('puntaje_ingles_4') ?? '0';
    ing4 = int.parse(score4);

    String score5 = prefs.getString('puntaje_ingles_5') ?? '0';
    ing5 = int.parse(score5);

    String score6 = prefs.getString('puntaje_ingles_6') ?? '0';
    ing6 = int.parse(score6);

    String score7 = prefs.getString('puntaje_ingles_7') ?? '0';
    ing7 = int.parse(score7);

    String score8 = prefs.getString('puntaje_ingles_8') ?? '0';
    ing8 = int.parse(score8);

    String score9 = prefs.getString('puntaje_ingles_9') ?? '0';
    ing9 = int.parse(score9);

    String score10 = prefs.getString('puntaje_ingles_10') ?? '0';
    ing10 = int.parse(score10);
  }

  Future<void> getPuntaje_LEC() async {
    final prefs = await SharedPreferences.getInstance();

    String score1 = prefs.getString('puntaje_lectura_1') ?? '0';
    lec1 = int.parse(score1);

    String score2 = prefs.getString('puntaje_lectura_2') ?? '0';
    lec2 = int.parse(score2);

    String score3 = prefs.getString('puntaje_lectura_3') ?? '0';
    lec3 = int.parse(score3);

    String score4 = prefs.getString('puntaje_lectura_4') ?? '0';
    lec4 = int.parse(score4);

    String score5 = prefs.getString('puntaje_lectura_5') ?? '0';
    lec5 = int.parse(score5);

    String score6 = prefs.getString('puntaje_lectura_6') ?? '0';
    lec6 = int.parse(score6);

    String score7 = prefs.getString('puntaje_lectura_7') ?? '0';
    lec7 = int.parse(score7);

    String score8 = prefs.getString('puntaje_lectura_8') ?? '0';
    lec8 = int.parse(score8);

    String score9 = prefs.getString('puntaje_lectura_9') ?? '0';
    lec9 = int.parse(score9);

    String score10 = prefs.getString('puntaje_lectura_10') ?? '0';
    lec10 = int.parse(score10);
  }

  Future<void> getPuntaje_CIU() async {
    final prefs = await SharedPreferences.getInstance();

    String score1 = prefs.getString('puntaje_ciudadanas_1') ?? '0';
    ciu1 = int.parse(score1);

    String score2 = prefs.getString('puntaje_ciudadanas_2') ?? '0';
    ciu2 = int.parse(score2);

    String score3 = prefs.getString('puntaje_ciudadanas_3') ?? '0';
    ciu3 = int.parse(score3);

    String score4 = prefs.getString('puntaje_ciudadanas_4') ?? '0';
    ciu4 = int.parse(score4);

    String score5 = prefs.getString('puntaje_ciudadanas_5') ?? '0';
    ciu5 = int.parse(score5);

    String score6 = prefs.getString('puntaje_ciudadanas_6') ?? '0';
    ciu6 = int.parse(score6);

    String score7 = prefs.getString('puntaje_ciudadanas_7') ?? '0';
    ciu7 = int.parse(score7);

    String score8 = prefs.getString('puntaje_ciudadanas_8') ?? '0';
    ciu8 = int.parse(score8);

    String score9 = prefs.getString('puntaje_ciudadanas_9') ?? '0';
    ciu9 = int.parse(score9);

    String score10 = prefs.getString('puntaje_ciudadanas_10') ?? '0';
    ciu10 = int.parse(score10);
  }

  Future<void> getPuntaje_COM() async {
    final prefs = await SharedPreferences.getInstance();

    String score1 = prefs.getString('puntaje_comunicacion_1') ?? '0';
    ciu1 = int.parse(score1);

    String score2 = prefs.getString('puntaje_comunicacion_2') ?? '0';
    ciu2 = int.parse(score2);

    String score3 = prefs.getString('puntaje_comunicacion_3') ?? '0';
    ciu3 = int.parse(score3);

    String score4 = prefs.getString('puntaje_comunicacion_4') ?? '0';
    ciu4 = int.parse(score4);

    String score5 = prefs.getString('puntaje_comunicacion_5') ?? '0';
    ciu5 = int.parse(score5);

    String score6 = prefs.getString('puntaje_comunicacion_6') ?? '0';
    ciu6 = int.parse(score6);

    String score7 = prefs.getString('puntaje_comunicacion_7') ?? '0';
    ciu7 = int.parse(score7);

    String score8 = prefs.getString('puntaje_comunicacion_8') ?? '0';
    ciu8 = int.parse(score8);

    String score9 = prefs.getString('puntaje_comunicacion_9') ?? '0';
    ciu9 = int.parse(score9);

    String score10 = prefs.getString('puntaje_comunicacion_10') ?? '0';
    ciu10 = int.parse(score10);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAvatarFromSharedPrefs();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getModuloFromSharedPrefs();
    getIsAvatar();
    getGender();
    _getAvatarFromSharedPrefs();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });

    //recibe el puntaje total del modulo mat y lo establece en variable para estitmar procentaje de progreso
    getPuntajesTotal_MAT().then((value) {
      setState(() {
        puntos_mat = value ?? 0;
      });
    });

    //recibe el puntaje total del modulo ing y lo establece en variable para estitmar procentaje de progreso
    getPuntajesTotal_ING().then((value) {
      setState(() {
        puntos_ing = value ?? 0;
      });
    });

    //recibe el puntaje total del modulo ing y lo establece en variable para estitmar procentaje de progreso
    getPuntajesTotal_LEC().then((value) {
      setState(() {
        puntos_lec = value ?? 0;
      });
    });

    //obtiene de shp cada nivel de puntaje y los actualiza
    getPuntaje_MAT();
    getPuntaje_ING();
    getPuntaje_LEC();
    getPuntaje_CIU();
    getPuntaje_COM();

    //----- INGLES
    getPuntajeIngles1_firestore();
    getPuntajeIngles2_firestore();
    getPuntajeIngles3_firestore();
    getPuntajeIngles4_firestore();
    getPuntajeIngles5_firestore();
    getPuntajeIngles6_firestore();
    getPuntajeIngles7_firestore();
    getPuntajeIngles8_firestore();
    //getPuntajeIngles9_firestore();
    getPuntajeIngles10_firestore();
    //----- MATEM
    getPuntajeMat1_firestore();
    getPuntajeMat2_firestore();
    getPuntajeMat3_firestore();
    getPuntajeMat4_firestore();
    getPuntajeMat5_firestore();
    getPuntajeMat6_firestore();
    getPuntajeMat7_firestore();
    getPuntajeMat8_firestore();
    //getPuntajeMat9_firestore();
    getPuntajeMat10_firestore();

    //-----LECTURA
    getPuntajeLectura1_firestore();

    //----CIUDADANAS
    getPuntajeCiudadanas1_firestore();
  }

  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat1_firestore() async {
    int puntajeMatNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_1', puntajeMatNivel1.toString());

    return puntajeMatNivel1;
  }

  //funcion que busca el nivel 2, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat2_firestore() async {
    int puntajeMatNivel2 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel2 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_2', puntajeMatNivel2.toString());

    return puntajeMatNivel2;
  }

  //funcion que busca el nivel 3, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat3_firestore() async {
    int puntajeMatNivel3 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel3 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_3', puntajeMatNivel3.toString());

    return puntajeMatNivel3;
  }

  //funcion que busca el nivel 4, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat4_firestore() async {
    int puntajeMatNivel4 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel4')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel4 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_4', puntajeMatNivel4.toString());

    return puntajeMatNivel4;
  }

  //funcion que busca el nivel 5, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat5_firestore() async {
    int puntajeMatNivel5 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel5')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel5 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_5', puntajeMatNivel5.toString());

    return puntajeMatNivel5;
  }

  //funcion que busca el nivel 6, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat6_firestore() async {
    int puntajeMatNivel6 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel6')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel6 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_6', puntajeMatNivel6.toString());

    return puntajeMatNivel6;
  }

  //funcion que busca el nivel 7, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat7_firestore() async {
    int puntajeMatNivel7 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel7')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel7 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_7', puntajeMatNivel7.toString());

    return puntajeMatNivel7;
  }

  //funcion que busca el nivel 6, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat8_firestore() async {
    int puntajeMatNivel8 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel8')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel8 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_8', puntajeMatNivel8.toString());

    return puntajeMatNivel8;
  }

/*   //funcion que busca el nivel 9, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat9_firestore() async {
    int puntajeMatNivel9 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel9')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel9 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_9', puntajeMatNivel9.toString());

    return puntajeMatNivel9;
  }
 */
  //funcion que busca el nivel 10, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeMat10_firestore() async {
    int puntajeMatNivel10 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('matematicas')
        .collection('nivel10')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeMatNivel10 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_mat_10', puntajeMatNivel10.toString());

    return puntajeMatNivel10;
  }

  //----------------------------- INGLES ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles1_firestore() async {
    int puntajeIngNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ingles_1', puntajeIngNivel1.toString());

    return puntajeIngNivel1;
  }

  //funcion que busca el nivel 2, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles2_firestore() async {
    int puntajeIngNivel2 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel2 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_2', puntajeIngNivel2.toString());
      }
    }

    return puntajeIngNivel2;
  }

  //funcion que busca el nivel 3, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles3_firestore() async {
    int puntajeIngNivel3 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel3 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_3', puntajeIngNivel3.toString());
      }
    }

    return puntajeIngNivel3;
  }

  //funcion que busca el nivel 4, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles4_firestore() async {
    int puntajeIngNivel4 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel4')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel4 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_4', puntajeIngNivel4.toString());
      }
    }

    return puntajeIngNivel4;
  }

  //funcion que busca el nivel 5, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles5_firestore() async {
    int puntajeIngNivel5 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel5')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel5 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_5', puntajeIngNivel5.toString());
      }
    }

    return puntajeIngNivel5;
  }

  //funcion que busca el nivel 6, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles6_firestore() async {
    int puntajeIngNivel6 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel6')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel6 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_6', puntajeIngNivel6.toString());
      }
    }

    return puntajeIngNivel6;
  }

  //funcion que busca el nivel 7, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles7_firestore() async {
    int puntajeIngNivel7 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel7')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel7 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_7', puntajeIngNivel7.toString());
      }
    }

    return puntajeIngNivel7;
  }

  //funcion que busca el nivel 8, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles8_firestore() async {
    int puntajeIngNivel8 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel8')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel8 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_8', puntajeIngNivel8.toString());
      }
    }

    return puntajeIngNivel8;
  }

  //funcion que busca el nivel 9, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles9_firestore() async {
    int puntajeIngNivel9 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel9')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel9 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('puntaje_ingles_9', puntajeIngNivel9.toString());
      }
    }

    return puntajeIngNivel9;
  }

  //funcion que busca el nivel 10, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeIngles10_firestore() async {
    int puntajeIngNivel10 = 0;

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ingles')
        .collection('nivel10')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeIngNivel10 = data['puntaje'] as int;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'puntaje_ingles_10', puntajeIngNivel10.toString());
      }
    }

    return puntajeIngNivel10;
  }

  //----------------------------- LECTURA ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeLectura1_firestore() async {
    int puntajeLecNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_1', puntajeLecNivel1.toString());

    return puntajeLecNivel1;
  }

  //----------------------------- CIUDADANAS ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeCiudadanas1_firestore() async {
    int puntajeCiuNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeCiuNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciudadanas_1', puntajeCiuNivel1.toString());

    return puntajeCiuNivel1;
  }

  @override
  Widget build(BuildContext context) {
    final double porcentaje_mat =
        puntos_mat / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_ing =
        puntos_ing / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_lec =
        puntos_lec / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_ciu =
        puntos_ciu / puntosMaximos_test; // Calcular el porcentaje de progreso

    final double porcentaje_test =
        puntos_test / puntosMaximos_test; // Calcular el porcentaje de progreso

    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        title: const Text(
          "Mis Puntajes",
          style: TextStyle(
            fontSize: 16.0,
            color: colors_colpaner.claro,
            /*fontWeight: FontWeight.bold*/
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
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
                  MaterialPageRoute(builder: (context) => const misPuntajes()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Progreso",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.oscuro,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                //--- PROGRESO
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Razonamiento\nCuantitativo',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                                textAlign: TextAlign
                                    .center, // Alineación horizontal del texto
                              ),
                            ),

                            //SE MUESTRA UN CIRCULO PROGRESS BAR
                            const SizedBox(height: 10),
                            Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          8, // Ancho del borde del círculo
                                      value:
                                          porcentaje_mat, // Valor de progreso
                                      backgroundColor: Colors.grey[
                                          300], // Color del fondo del círculo
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors
                                                  .blue), // Color del progreso
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${(porcentaje_mat * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro,
                                            fontFamily: 'BubblegumSans'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                '\nInglés',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                                textAlign: TextAlign
                                    .center, // Alineación horizontal del texto
                              ),
                            ),
                            //SE MUESTRA UN CIRCULO PROGRESS BAR
                            const SizedBox(height: 10),
                            Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          8, // Ancho del borde del círculo
                                      value:
                                          porcentaje_ing, // Valor de progreso
                                      backgroundColor: Colors.grey[
                                          300], // Color del fondo del círculo
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors
                                                  .blue), // Color del progreso
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${(porcentaje_ing * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro,
                                            fontFamily: 'BubblegumSans'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Lectura\nCrítica',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                                textAlign: TextAlign
                                    .center, // Alineación horizontal del texto
                              ),
                            ),
                            //SE MUESTRA UN CIRCULO PROGRESS BAR
                            const SizedBox(height: 10),
                            Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          8, // Ancho del borde del círculo
                                      value:
                                          porcentaje_lec, // Valor de progreso
                                      backgroundColor: Colors.grey[
                                          300], // Color del fondo del círculo
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors
                                                  .blue), // Color del progreso
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${(porcentaje_lec * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro,
                                            fontFamily: 'BubblegumSans'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Competencias\nCiudadanas',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.claro,
                                ),
                                textAlign: TextAlign
                                    .center, // Alineación horizontal del texto
                              ),
                            ),
                            //SE MUESTRA UN CIRCULO PROGRESS BAR
                            const SizedBox(height: 10),
                            Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          8, // Ancho del borde del círculo
                                      value:
                                          porcentaje_ciu, // Valor de progreso
                                      backgroundColor: Colors.grey[
                                          300], // Color del fondo del círculo
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors
                                                  .blue), // Color del progreso
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${(porcentaje_ciu * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro,
                                            fontFamily: 'BubblegumSans'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      /*  Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                        child: Column(
                          children: [
                            const Text(
                              'Razonamiento Cuantitativo',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'BubblegumSans',
                                fontWeight: FontWeight.bold,
                                color: colors_colpaner.claro,
                              ),
                            ),
                            //SE MUESTRA UN CIRCULO PROGRESS BAR
                            const SizedBox(height: 10),
                            Center(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth:
                                          8, // Ancho del borde del círculo
                                      value:
                                          porcentaje_test, // Valor de progreso
                                      backgroundColor: Colors.grey[
                                          300], // Color del fondo del círculo
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors
                                                  .blue), // Color del progreso
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        '${(porcentaje_test * 100).toStringAsFixed(0)}%', // Texto con el porcentaje de progreso
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: colors_colpaner.claro,
                                            fontFamily: 'BubblegumSans'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), */
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                //MATEMATICAS NIVELES
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Razonamiento Cuantitativo",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //1
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat1.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),
                      //2
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat2.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //3
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat3.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //4
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 4',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat4.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //5
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 5',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat5.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //6
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat6.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //7
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 7',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat7.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //8
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 8',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat8.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //9
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 9',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat9.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //10
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 10',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    mat10.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/30',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                //INGLES NIVELES
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Inglés",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //1
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing1.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //2
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing2.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //3
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing3.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //4
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 4',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing4.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //5
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 5',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing5.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //6
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing6.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/10',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //7
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 7',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing7.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //8
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 8',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing8.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //9
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 9',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing9.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //10
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 10',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ing10.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/30',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                //LECTURA CRITICA NIVELES
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Lectura Crítica",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //1
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec1.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //2
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec2.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //3
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec3.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //4
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 4',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec4.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //5
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 5',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec5.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //6
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec6.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/10',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //7
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 7',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec7.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //8
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 8',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec8.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //9
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 9',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec9.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //10
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 10',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lec10.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/30',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                //SOCIALES Y CIUDADANAS
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Competencias Ciudadanas",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //1
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu1.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //2
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu2.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //3
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu3.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //4
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 4',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu4.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //5
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 5',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu5.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //6
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu6.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/10',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //7
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 7',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu7.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //8
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 8',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu8.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //9
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 9',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu9.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //10
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 10',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ciu10.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/30',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                //COMUNICACION ESCRITA
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Ciencias Naturales",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //1
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 1',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat1.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //2
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 2',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat2.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //3
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 3',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat3.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //4
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 4',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat4.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //5
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 5',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat5.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //6
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat6.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/10',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //7
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 7',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat7.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //8
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 8',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat8.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      //9
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 9',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat9.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      //10
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Nivel 10',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'BubblegumSans',
                                  fontWeight: FontWeight.bold,
                                  color: colors_colpaner.oscuro,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    nat10.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  ),
                                  const Text(
                                    '/30',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'BubblegumSans',
                                      fontWeight: FontWeight.bold,
                                      color: colors_colpaner.base,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: colors_colpaner.oscuro,
                ),

                Stack(children: [
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
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            "Ranking",
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
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (int i = 0; i < 6; i++)
                                Container(
                                  height: 45, // Altura de cada celda
                                  color: colors[
                                      i % 2], // Alternar colores de la lista
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerColpaner(
        context: context,
        screen: 'puntajes',
      ),
    );
  }

/*   //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    _getAvatarFromSharedPrefs();

    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser;

    String tecnicaElegida;

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        color: colors_colpaner.base,
        child: ListView(
          children: <Widget>[
            Container(
              //height: 150.0,
              alignment: Alignment.center,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  CachedNetworkImage(
                    fadeInDuration: Duration.zero,
                    imageUrl: _imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(loggedInUser.fullName.toString(),
                        style: const TextStyle(
                            fontFamily: 'BubblegumSans',
                            color: colors_colpaner.claro,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text('Técnica de ${loggedInUser.tecnica}',
                      style: const TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: colors_colpaner.claro,
                      )),
                  Text(loggedInUser.email.toString(),
                      style: const TextStyle(
                        fontFamily: 'BubblegumSans',
                        fontSize: 10,
                        color: colors_colpaner.claro,
                      )),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            ListTile(
                title: const Text("Entrenamiento",
                    style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: colors_colpaner.oscuro,
                        fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.psychology,
                  color: colors_colpaner.oscuro,
                ),
                onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const entrenamientoModulos())),
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.claro,
                    )),
                leading: const Icon(
                  Icons.sports_score,
                  color: colors_colpaner.claro,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
              title: const Text("Ávatar",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.face,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () async {
                if (isAvatar == true) {
                  if (gender == 'male') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const avatarsMale()));
                  }

                  if (gender == 'female') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const avatarsFemale()));
                  }
                } else {
                  DialogHelper.gender_dialog(context);
                }
              },
            ),
            ListTile(
              title: const Text("Patrones ICFES",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.insights,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Usabilidad",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.extension,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            SizedBox(
              height: drawer_height * 0.17,
            ),
            ListTile(
              title: const Text("",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.settings,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            const Divider(
              color: colors_colpaner.claro,
            ),
            ListTile(
              title: const Text("Cerrar sesión",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.logout,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {
                clearSharedPreferences();
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
 */
  // función para eliminar todos los registros de Shared Preferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
