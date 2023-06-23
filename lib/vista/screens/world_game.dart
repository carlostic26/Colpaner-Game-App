import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/niveles/level1/level1_quiz.dart';
import 'package:gamicolpaner/vista/screens/niveles/level10/simulacro.dart';
import 'package:gamicolpaner/vista/screens/niveles/level2/level2.dart';
import 'package:gamicolpaner/vista/screens/niveles/level3/level3.dart';
import 'package:gamicolpaner/vista/screens/niveles/level4/level4.dart';
import 'package:gamicolpaner/vista/screens/niveles/level5/level5_quiz.dart';
import 'package:gamicolpaner/vista/screens/niveles/level6/level6.dart';
import 'package:gamicolpaner/vista/screens/niveles/level7/level7.dart';
import 'package:gamicolpaner/vista/screens/niveles/level8/level8.dart';
import 'package:gamicolpaner/vista/screens/niveles/level9/level9.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class world_game extends StatefulWidget {
  const world_game({Key? key}) : super(key: key);

  @override
  State<world_game> createState() => _world_gameState();
}

class _world_gameState extends State<world_game> {
  String _modulo = '';

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  late Image button1,
      button2,
      button3,
      button4,
      button5,
      button6,
      button7,
      button8,
      button9,
      button10;

  bool btn1_Pressed = false;
  bool btn2_Pressed = false;
  bool btn3_Pressed = false;
  bool btn4_Pressed = false;
  bool btn5_Pressed = false;
  bool btn6_Pressed = false;
  bool btn7_Pressed = false;
  bool btn8_Pressed = false;
  bool btn9_Pressed = false;
  bool btn10_Pressed = false;
  bool btn1_Unpressed = true;
  bool btn2_Unpressed = true;
  bool btn3_Unpressed = true;
  bool btn4_Unpressed = true;
  bool btn5_Unpressed = true;
  bool btn6_Unpressed = true;
  bool btn7_Unpressed = true;
  bool btn8_Unpressed = true;
  bool btn9_Unpressed = true;
  bool btn10_Unpressed = true;

  Image buttonPressed = Image.asset(
    'assets/button/button_pushed.png',
  );
  Image buttonUnpressed = Image.asset(
    'assets/button/button_unpushed.png',
  );

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  String _imageUrl =
      'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';
    });
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
    button1 = buttonUnpressed;
    button2 = buttonUnpressed;
    button3 = buttonUnpressed;
    button4 = buttonUnpressed;
    button5 = buttonUnpressed;
    button6 = buttonUnpressed;
    button7 = buttonUnpressed;
    button8 = buttonUnpressed;
    button9 = buttonUnpressed;
    button10 = buttonUnpressed;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
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
    //getPuntajeMat7_firestore();
    getPuntajeMat10_firestore();

    //----- LECTURA
    getPuntajeLectura1_firestore();
    getPuntajeLectura2_firestore();

    //----- SOCIALES
    getPuntajeSociales1_firestore();
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
    await prefs.setString('puntaje_mat_7', puntajeMatNivel9.toString());

    return puntajeMatNivel9;
  } */
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
    await prefs.setString('puntaje_mat_7', puntajeMatNivel10.toString());

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

/*   //funcion que busca el nivel 9, si existe, lo envia a shp para ser sumado a puntaje total
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
  } */

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

  Future<int> getPuntajeLectura2_firestore() async {
    int puntajeLecNivel2 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel2 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_2', puntajeLecNivel2.toString());

    return puntajeLecNivel2;
  }

  Future<int> getPuntajeLectura3_firestore() async {
    int puntajeLecNivel3 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel3 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_3', puntajeLecNivel3.toString());

    return puntajeLecNivel3;
  }

  Future<int> getPuntajeLectura4_firestore() async {
    int puntajeLecNivel4 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel4')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel4 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_4', puntajeLecNivel4.toString());

    return puntajeLecNivel4;
  }

  Future<int> getPuntajeLectura5_firestore() async {
    int puntajeLecNivel5 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel5')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel5 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_5', puntajeLecNivel5.toString());

    return puntajeLecNivel5;
  }

  Future<int> getPuntajeLectura6_firestore() async {
    int puntajeLecNivel6 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel6')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel6 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_6', puntajeLecNivel6.toString());

    return puntajeLecNivel6;
  }

  Future<int> getPuntajeLectura7_firestore() async {
    int puntajeLecNivel7 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel7')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel7 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_7', puntajeLecNivel7.toString());

    return puntajeLecNivel7;
  }

  Future<int> getPuntajeLectura8_firestore() async {
    int puntajeLecNivel8 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel8')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel8 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_8', puntajeLecNivel8.toString());

    return puntajeLecNivel8;
  }

  Future<int> getPuntajeLectura10_firestore() async {
    int puntajeLecNivel10 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel10')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel10 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_10', puntajeLecNivel10.toString());

    return puntajeLecNivel10;
  }

  //----------------------------- SOCIALES ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeSociales1_firestore() async {
    int puntajeSocNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('sociales')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_sociales_1', puntajeSocNivel1.toString());

    return puntajeSocNivel1;
  }

  @override
  Widget build(BuildContext context) {
    _getAvatarFromSharedPrefs();
    final double totalWidth = MediaQuery.of(context).size.width;
    final double cellWidth = (totalWidth - 16) / 3;
    final double cellHeight = 40 / 3 * cellWidth;
    return Scaffold(
        appBar: null,
        body: Center(
          child: Stack(
            children: [
              //img fondo candy
              Center(
                child: CachedNetworkImage(
                  fadeInDuration: Duration.zero,
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg5Q4hvD_1Mg-3b4w0_w4rnkdo8iHWn1Pp2hLCbKLnnW4eUPY1LnmKF20V0zcIMNSJHSDUgqvVBNJqOodIeVRG87TewfsawutA9AdVEJpYxFVhBCoSpo6sVGKGe6uOLXG2KyuxYYR218nXHid185Agcdc-RkbrYrnw0FB3WWX7HBgs8kxesCJCf8k0/s16000/solo%20ruta%203.png',
                  height: MediaQuery.of(context).size.height * 1.0,
                  width: MediaQuery.of(context).size.width * 1.0,
                  fit: BoxFit.fill,
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ShakeWidgetY(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1.0),
                            width: MediaQuery.of(context).size.width,
                            height: 125,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/banner_user.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),

                          Positioned(
                            top: 50,
                            left: MediaQuery.of(context).size.width * 0.1225,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  loggedInUser.fullName.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 14),
                                ),
                                Text(
                                  _modulo,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: _modulo.length >= 19 ? 9 : 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //image avatar
                          Positioned(
                            top: 45,
                            left: MediaQuery.of(context).size.width * 0.425,
                            child: Container(
                                padding: const EdgeInsets.all(1.0),
                                width: 70,
                                height: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    width: cellWidth,
                                    height: cellHeight,
                                    child: CachedNetworkImage(
                                      imageUrl: _imageUrl,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.685,
                            top: 45,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 1, 1),
                              child: Column(
                                children: [
                                  const Text(
                                    "Puntaje total",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 13),
                                  ),
                                  FutureBuilder<int>(
                                    future:
                                        _modulo == 'Razonamiento Cuantitativo'
                                            ? getPuntajesTotal_MAT()
                                            : _modulo == 'Inglés'
                                                ? getPuntajesTotal_ING()
                                                : _modulo == 'Lectura Crítica'
                                                    ? getPuntajesTotal_LEC()
                                                    : getPuntajesTotal_MAT(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'BubblegumSans',
                                            fontSize: 13,
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
                    ),
                  ],
                ),
              ),

              Positioned(
                right: MediaQuery.of(context).size.width * 0.325,
                top: MediaQuery.of(context).size.height * 0.135,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: GestureDetector(
                        child: button10,
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 40,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button10 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button10 = buttonUnpressed;
                          });
                          showDialogLevel(10, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '10',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //btn 9
              Positioned(
                right: MediaQuery.of(context).size.width * 0.66,
                top: MediaQuery.of(context).size.height * 0.258,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    SizedBox(
                      height: 62,
                      width: 62,
                      child: GestureDetector(
                        child: button9,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 25,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button9 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button9 = buttonUnpressed;
                          });
                          showDialogLevel(9, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '9',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn 8
              Positioned(
                right: MediaQuery.of(context).size.width * 0.66,
                top: MediaQuery.of(context).size.height * 0.355,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: GestureDetector(
                        child: button8,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 28,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button8 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button8 = buttonUnpressed;
                          });
                          showDialogLevel(8, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '8',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn 7
              Positioned(
                right: MediaQuery.of(context).size.width * 0.38,
                top: MediaQuery.of(context).size.height * 0.358,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: GestureDetector(
                        child: button7,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 30,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button7 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button7 = buttonUnpressed;
                          });
                          showDialogLevel(7, _modulo);
                        },
                        child: const Text(
                          '7',
                          style: TextStyle(
                            color: colors_colpaner.claro,
                            fontFamily: 'BubblegumSans',
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

//btn 6
              Positioned(
                right: MediaQuery.of(context).size.width * 0.0692,
                bottom: MediaQuery.of(context).size.height * 0.48,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        child: button6,
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 32,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button6 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button6 = buttonUnpressed;
                          });
                          showDialogLevel(6, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '6',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              //btn 5
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                bottom: MediaQuery.of(context).size.height * 0.427,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        child: button5,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 32,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button5 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button5 = buttonUnpressed;
                          });
                          showDialogLevel(5, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '5',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn 4
              Positioned(
                left: MediaQuery.of(context).size.width * 0.083,
                bottom: MediaQuery.of(context).size.height * 0.41,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        child: button4,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 30,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button4 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button4 = buttonUnpressed;
                          });
                          showDialogLevel(4, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '4',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn 3
              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                bottom: MediaQuery.of(context).size.height * 0.289,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: GestureDetector(
                        child: button3,
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 43,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button3 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button3 = buttonUnpressed;
                          });
                          showDialogLevel(3, _modulo);
                        },
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn 2
              Positioned(
                left: MediaQuery.of(context).size.width * 0.422,
                bottom: MediaQuery.of(context).size.height * 0.195,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: GestureDetector(
                        child: button2,
                      ),
                    ),
                    Positioned(
                      top: 19,
                      left: 38,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            button2 = buttonPressed;
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            button2 = buttonUnpressed;
                          });
                          showDialogLevel(2, _modulo);
                        },
                        child: const SizedBox(
                          height: 80,
                          width: 100,
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: colors_colpaner.claro,
                              fontFamily: 'BubblegumSans',
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //btn inicial 1
              Positioned(
                left: MediaQuery.of(context).size.width * 0.375,
                bottom: MediaQuery.of(context).size.height * 0.028,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    SizedBox(
                      height: 125,
                      width: 125,
                      child: GestureDetector(
                        child: button1,
                      ),
                    ),
                    Positioned(
                        top: 25,
                        left: 55,
                        child: GestureDetector(
                          onTapDown: (tap) {
                            setState(() {
                              button1 = buttonPressed;
                            });
                          },
                          onTapUp: (tap) {
                            setState(() {
                              button1 = buttonUnpressed;
                            });
                            showDialogLevel(1, _modulo);
                          },
                          child: const SizedBox(
                            height: 100,
                            width: 100,
                            child: Positioned(
                              top: 25,
                              left: 55,
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: colors_colpaner.claro,
                                  fontFamily: 'BubblegumSans',
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]),
                ),
              ),

              //btn regresar
              Align(
                alignment: Alignment.bottomLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.2,
                  heightFactor: 0.12,
                  child: ShakeWidgetX(
                    child: IconButton(
                      icon: Image.asset('assets/flecha_left.png'),
                      iconSize: 50,
                      onPressed: () {
                        //_soundBack();
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
                                      curve: Curves.elasticInOut);

                                  return ScaleTransition(
                                    alignment: Alignment.center,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secAnimattion) {
                                  return const entrenamientoModulos();
                                }));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<String> obtenerNombre() async {
    // Coloque aquí su código para obtener el nombre desde Firebase
    // Por ejemplo, si su nombre de campo es "nombre" y está almacenado en Firestore:
    // var snapshot = await FirebaseFirestore.instance.collection('usuarios').doc(id).get();
    // var nombre = snapshot.data()['nombre'];
    // return nombre;
    return "Nombre desde Firebase";
  }

  bool btn1Pressed = false;

  // ignore: non_constant_identifier_names
  void ChangedImageFunction() {
    Image.asset("assets/button_pushed.png");

    setState(() {
      btn1Pressed = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      Image.asset("assets/button_unpushed.png");
    });
  }

  void showDialogLevel(int level, String? modulo) {
    String imageLvl1 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjTy5Oytt0iwUvfxK4rm2nGlFjPENSj1kk-2bwqYAM1rzPtncL68VR9eUYTK9vbyByREPPtdGUAUupeM8f_CD5KsmgZbJe8k3WAw4--qhFxpcpFgGqsq1u2saxiui1FfP704AjtaBlGlSOsrpi31Upev6OA5612vSGY23eh7wAS24TGlS8hUHxHa6s=s16000';
    String imageLvl2 =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2Z-aZWSpJfAT6p1ki7lhQrWW-qO5hRj6T4p0DDxrvx9WxNH5pH2a0CSRmYa4POVjKp4J5khGE17BmDhaNUsGo0QMpRPoL3HoDgc0WIqFxCsktAr9_s1D8oIVvlUoNs9_5tiNR3XcJvOqEWRBmEAbQK-BuypAjMRLUYIXj23MUK02i0uUNVMXprjs/s1600/MajesticIdioticArachnid-max-1mb.gif';
    String imageLvl3 =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibTjDUT6fzseikZx3rWGw4HYlabuuCN5zwgw0XYH_I8Nhbvfkyf0Xhy6bAsmrXwDssgFcS9QhjyPq92E3ykPCJlUmPCFAhR8IWb__hSlXnT_LeNSXSBpbp6wXz1WJInRSzbmMCbLc4BajiPFqs3qUHMxmetHZNaCg6n9ABZSNFR_u38F4FOo8QBwQ/s320/Word%20Search%20Puzzles%20Gameplay.gif';

    String imageLvl4 =
        'https://developer.android.com/static/images/guide/topics/ui/drag-and-drop-between-apps.gif?hl=es-419';
    String imageLvl5 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjTy5Oytt0iwUvfxK4rm2nGlFjPENSj1kk-2bwqYAM1rzPtncL68VR9eUYTK9vbyByREPPtdGUAUupeM8f_CD5KsmgZbJe8k3WAw4--qhFxpcpFgGqsq1u2saxiui1FfP704AjtaBlGlSOsrpi31Upev6OA5612vSGY23eh7wAS24TGlS8hUHxHa6s=s16000';

    String imageLvl6 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEguCWt1PDbfMXq7mO2uNFeqQyovN4Vmym-_PVGl5POPu14e81QHqByoxtMvbUo7OQyLeB-1JudLptZEB9PvDeuHH6NbzhbWDYdPyablavwf_SoyLd8r1WmZ4Bv_FlWpVetpiaNk0UOMVp1SGsHvVrxg6OcGUpJqYHUS_tHa8NCa_uOxW2jViKqUX1c';
    String imageLvl7 =
        'http://pa1.narvii.com/6625/e90f6237ad16279bb59f3b3dea459eae44b831b5_00.gif';

    String imageLvl8 =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjI79k1GOYleWN59tGVXduBRPzRn9V9WcKNGMO1BvogbpAyrUteln0NOQDgTkNjYB6QIMVxfIrhxXcw5IDU3zFmUJN1OBUbrpB6-w4YDCQjUdYt5rK_4Lu3A1AlXJpEKtcJXCgjiKypufU9gaE1MVtDdgL738lQ9lpFQNf2b_-HJnv1MynFYm6Cbds/s320/giphy.gif';
    String imageLvl9 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjTy5Oytt0iwUvfxK4rm2nGlFjPENSj1kk-2bwqYAM1rzPtncL68VR9eUYTK9vbyByREPPtdGUAUupeM8f_CD5KsmgZbJe8k3WAw4--qhFxpcpFgGqsq1u2saxiui1FfP704AjtaBlGlSOsrpi31Upev6OA5612vSGY23eh7wAS24TGlS8hUHxHa6s=s16000';
    String imageLvl10 =
        'https://blogger.googleusercontent.com/img/a/AVvXsEj_3Z1kqIpcWZZpGfyXAb9t0fEB0CLZ3jWyVyOZn_jgvYnocpT3Ayj8YKWio-LnlYr0MODwboL1397Cnjs8XVHFHnpAK7nALOPyP-GmWbBVhxg8nc3DHopcHtYluoPBV0no2U7EoZofmi8tH2K8Q3XG6-Fp39XnoZhKX0L-2zMqtNnbW0TpuZzwcmg';

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
                image: CachedNetworkImage(
                  imageUrl: level == 1
                      ? imageLvl1
                      : level == 2
                          ? imageLvl2
                          : level == 3
                              ? imageLvl3
                              : level == 4
                                  ? imageLvl4
                                  : level == 5
                                      ? imageLvl5
                                      : level == 6
                                          ? imageLvl6
                                          : level == 7
                                              ? imageLvl7
                                              : level == 8
                                                  ? imageLvl8
                                                  : level == 9
                                                      ? imageLvl9
                                                      : level == 10
                                                          ? imageLvl10
                                                          : imageLvl10,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: level == 1
                    ? const Text(
                        'Test de conocimientos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.w600),
                      )
                    : level == 2
                        ? const Text(
                            '¡Match Cards!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'BubblegumSans',
                                fontWeight: FontWeight.w600),
                          )
                        : level == 3
                            ? const Text(
                                'Sopa de letras',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'BubblegumSans',
                                    fontWeight: FontWeight.w600),
                              )
                            : level == 4
                                ? const Text(
                                    '¡Drag and drop!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'BubblegumSans',
                                        fontWeight: FontWeight.w600),
                                  )
                                : level == 5
                                    ? const Text(
                                        'Nivel 5',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'BubblegumSans',
                                            fontWeight: FontWeight.w600),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'Nivel 6',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'BubblegumSans',
                                                fontWeight: FontWeight.w600),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'Nivel 7',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'BubblegumSans',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : level == 8
                                                ? const Text(
                                                    'Nivel 8',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'BubblegumSans',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : level == 9
                                                    ? const Text(
                                                        'Nivel 9',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'BubblegumSans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    : level == 10
                                                        ? const Text(
                                                            'Simulacro',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'BubblegumSans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        : const Text(''),
                description: level == 1
                    ? const Text(
                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontFamily: 'BubblegumSans'),
                      )
                    : level == 2
                        ? const Text(
                            'En este nivel tendrás que prestar mucha atención a la afirmación de cada tarjeta. Tu tarea es entenderlas y hacer que coincidan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'BubblegumSans'),
                          )
                        : level == 3
                            ? Text(
                                'En este nivel verás conceptos del modulo de $_modulo que debes tener en cuenta para la prueba, encontrándolos en una sopa de letras.\n\nTienes 1 minuto para terminar.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 13, fontFamily: 'BubblegumSans'),
                              )
                            : level == 4
                                ? const Text(
                                    'En este nivel tendrás que leer conceptos (zona izquierda) y asociarlos con la respuesta correcta (zona derecha). Tienes un numero limite de intentos.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'BubblegumSans'),
                                  )
                                : level == 5
                                    ? const Text(
                                        'En este nivel realizarás un quiz intermedio sobre la usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'BubblegumSans'),
                                      )
                                    : level == 6
                                        ? const Text(
                                            'En este nivel tendrás que leer una afirmación y elegir si es falsa o verdadera. Concéntrate e intenta sacar el mejor puntaje.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'BubblegumSans'),
                                          )
                                        : level == 7
                                            ? const Text(
                                                'En este nivel tendrás que leer una afirmación y escribir la palabra exacta que la define. Tienes un número limitado de intentos.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'BubblegumSans'),
                                              )
                                            : level == 8
                                                ? Text(
                                                    'En este nivel tendrás que girar una ruleta que contiene algunos temas que evalua el icfes en el modulo de $modulo.\n\nDeberás pasar al tablero y responder con tus palabras par qué sirve en la vida real.',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'BubblegumSans'),
                                                  )
                                                : level == 9
                                                    ? const Text(
                                                        'En este nivel realizarás un quiz básico sobre usabilidad del examen ICFES Saber PRO para validar los conocimientos de la prueba',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'BubblegumSans'),
                                                      )
                                                    : level == 10
                                                        ? Text(
                                                            'Este es el último nivel de Colpaner App.\nRealizarás el simulacro del modulo de $modulo pero esta vez no podrás ver las respuestas correctas o incorrectas de forma inmediata. \n\nTienes x minutos para terminar.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'BubblegumSans'),
                                                          )
                                                        : const Text(''),
                buttonOkText: const Text(
                  'Ir',
                  style: TextStyle(color: Colors.white),
                ),
                buttonCancelText: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
                buttonOkColor: Colors.green,
                onOkButtonPressed: () async {
                  // Acciones al presionar el boton OK

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
                              parent: animation, curve: Curves.elasticInOut);

                          return ScaleTransition(
                            alignment: Alignment.center,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimattion) {
                          int scoreTot = 0;

                          return level == 1
                              ? const level1Quiz()
                              : level == 2
                                  ? const level2()
                                  : level == 3
                                      ? const level3()
                                      : level == 4
                                          ? const level4()
                                          : level == 5
                                              ? const level5Quiz()
                                              : level == 6
                                                  ? const level6()
                                                  : level == 7
                                                      ? const level7()
                                                      : level == 8
                                                          ? const level8()
                                                          : level == 9
                                                              ? const level9Quiz()
                                                              : level == 10
                                                                  ? const simulacro()
                                                                  : const world_game();
                        }),
                  );
                }),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}
