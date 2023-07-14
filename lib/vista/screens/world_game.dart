import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
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
      btnDisable,
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

  Image buttonDisable = Image.asset('assets/button/button_blocked.png');

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
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
    getDataSharedPreferences();
    _getAvatarFromSharedPrefs();
    getScoreMatShp();
    getButtonEnabled();
  }

  bool niv2enabled = false;
  bool niv3enabled = false;
  bool niv4enabled = false;
  bool niv5enabled = false;
  bool niv6enabled = false;
  bool niv7enabled = false;
  bool niv8enabled = false;
  bool niv9enabled = false;
  bool niv10enabled = false;

  void getButtonEnabled() async {
    LocalStorage storage = LocalStorage();

    switch (_modulo) {
      case 'Razonamiento Cuantitativo':
        niv2enabled = (await storage.getMatBtn2Enabled())!;
        niv3enabled = (await storage.getMatBtn3Enabled())!;
        niv4enabled = (await storage.getMatBtn4Enabled())!;
        niv5enabled = (await storage.getMatBtn5Enabled())!;
        niv6enabled = (await storage.getMatBtn6Enabled())!;
        niv7enabled =
            true; //niv7enabled = (await storage.getMatBtn7Enabled())!;
        niv8enabled = (await storage.getMatBtn8Enabled())!;
        niv9enabled = (await storage.getMatBtn9Enabled())!;
        niv10enabled = (await storage.getMatBtn10Enabled())!;

        //print('IMPRIMIENDO BOOL BTN 2 DESDE METOD GETBUTTNENABLED: $niv2enabled');

        break;

      case 'Inglés':
        niv2enabled = (await storage.getIngBtn2Enabled())!;
        niv3enabled = (await storage.getIngBtn3Enabled())!;
        niv4enabled = (await storage.getIngBtn4Enabled())!;
        niv5enabled = (await storage.getIngBtn5Enabled())!;
        niv6enabled = (await storage.getIngBtn6Enabled())!;
        niv7enabled = (await storage.getIngBtn7Enabled())!;
        niv8enabled = (await storage.getIngBtn8Enabled())!;
        niv9enabled = (await storage.getIngBtn9Enabled())!;
        niv10enabled = (await storage.getIngBtn10Enabled())!;
        break;

      case 'Ciencias Naturales':
        niv2enabled = (await storage.getNatBtn2Enabled())!;
        niv3enabled = (await storage.getNatBtn3Enabled())!;
        niv4enabled = (await storage.getNatBtn4Enabled())!;
        niv5enabled = (await storage.getNatBtn5Enabled())!;
        niv6enabled = (await storage.getNatBtn6Enabled())!;
        niv7enabled = (await storage.getNatBtn7Enabled())!;
        niv8enabled = (await storage.getNatBtn8Enabled())!;
        niv9enabled = (await storage.getNatBtn9Enabled())!;
        niv10enabled = (await storage.getNatBtn10Enabled())!;
        break;

      case 'Competencias Ciudadanas':
        niv2enabled = (await storage.getCiuBtn2Enabled())!;
        niv3enabled = (await storage.getCiuBtn3Enabled())!;
        niv4enabled = (await storage.getCiuBtn4Enabled())!;
        niv5enabled = (await storage.getCiuBtn5Enabled())!;
        niv6enabled = (await storage.getCiuBtn6Enabled())!;
        niv7enabled = (await storage.getCiuBtn7Enabled())!;
        niv8enabled = (await storage.getCiuBtn8Enabled())!;
        niv9enabled = (await storage.getCiuBtn9Enabled())!;
        niv10enabled = (await storage.getCiuBtn10Enabled())!;
        break;

      case 'Lectura Crítica':
        niv2enabled = (await storage.getLecBtn2Enabled())!;
        niv3enabled = (await storage.getLecBtn3Enabled())!;
        niv4enabled = (await storage.getLecBtn4Enabled())!;
        niv5enabled = (await storage.getLecBtn5Enabled())!;
        niv6enabled = (await storage.getLecBtn6Enabled())!;
        niv7enabled = (await storage.getLecBtn7Enabled())!;
        niv8enabled = (await storage.getLecBtn8Enabled())!;
        niv9enabled = (await storage.getLecBtn9Enabled())!;
        niv10enabled = (await storage.getLecBtn10Enabled())!;
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrefs();
    getDataSharedPreferences();
    _getModuloFromSharedPrefs();

    btnDisable = buttonDisable;
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
    //print('IMPRIMIENDO BOOL BTN 2 DESDE INIT STATE WORLDGAME: $niv2enabled');
    //getButtonEnabled();

    //----- INGLES
    getPuntajeIngles1_firestore();
    getPuntajeIngles2_firestore();
    getPuntajeIngles3_firestore();
    getPuntajeIngles4_firestore();
    getPuntajeIngles5_firestore();
    getPuntajeIngles6_firestore();
    getPuntajeIngles7_firestore();
    getPuntajeIngles8_firestore();
    getPuntajeIngles9_firestore();
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
    getPuntajeMat7_firestore();
    getPuntajeMat10_firestore();

    //----- NATURALES
    getPuntajeNat1_firestore();
    getPuntajeNat2_firestore();
    getPuntajeNat3_firestore();
    getPuntajeNat4_firestore();
    getPuntajeNat5_firestore();
    getPuntajeNat6_firestore();
    getPuntajeNat7_firestore();
    getPuntajeNat8_firestore();
    getPuntajeNat7_firestore();
    getPuntajeNat10_firestore();

    //----- LECTURA
    getPuntajeLectura1_firestore();
    getPuntajeLectura2_firestore();
    getPuntajeLectura3_firestore();
    getPuntajeLectura4_firestore();
    getPuntajeLectura5_firestore();
    getPuntajeLectura6_firestore();
    getPuntajeLectura7_firestore();
    getPuntajeLectura8_firestore();
    getPuntajeLectura9_firestore();
    getPuntajeLectura10_firestore();

    //----- SOCIALES
    getPuntajeCiudadanas1_firestore();
    getPuntajeCiudadanas2_firestore();
    getPuntajeCiudadanas3_firestore();
    getPuntajeCiudadanas4_firestore();
    getPuntajeCiudadanas5_firestore();
    getPuntajeCiudadanas6_firestore();
    getPuntajeCiudadanas7_firestore();
    getPuntajeCiudadanas8_firestore();
    getPuntajeCiudadanas9_firestore();
    getPuntajeCiudadanas10_firestore();
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

  Future<int> getPuntajeLectura9_firestore() async {
    int puntajeLecNivel9 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('lectura')
        .collection('nivel9')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeLecNivel9 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_lectura_9', puntajeLecNivel9.toString());

    return puntajeLecNivel9;
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

  //----------------------------- CIUDADANAS ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeCiudadanas1_firestore() async {
    int puntajeSocNivel1 =
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
        puntajeSocNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_1', puntajeSocNivel1.toString());

    return puntajeSocNivel1;
  }

  Future<int> getPuntajeCiudadanas2_firestore() async {
    int puntajeSocNivel2 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel2 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_2', puntajeSocNivel2.toString());

    return puntajeSocNivel2;
  }

  Future<int> getPuntajeCiudadanas3_firestore() async {
    int puntajeSocNivel3 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel3 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_3', puntajeSocNivel3.toString());

    return puntajeSocNivel3;
  }

  Future<int> getPuntajeCiudadanas4_firestore() async {
    int puntajeSocNivel4 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel4')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel4 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_4', puntajeSocNivel4.toString());

    return puntajeSocNivel4;
  }

  Future<int> getPuntajeCiudadanas5_firestore() async {
    int puntajeSocNivel5 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel5')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel5 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_5', puntajeSocNivel5.toString());

    return puntajeSocNivel5;
  }

  Future<int> getPuntajeCiudadanas6_firestore() async {
    int puntajeSocNivel6 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel6')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel6 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_6', puntajeSocNivel6.toString());

    return puntajeSocNivel6;
  }

  Future<int> getPuntajeCiudadanas7_firestore() async {
    int puntajeSocNivel7 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel7')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel7 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_7', puntajeSocNivel7.toString());

    return puntajeSocNivel7;
  }

  Future<int> getPuntajeCiudadanas8_firestore() async {
    int puntajeSocNivel8 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel8')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel8 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_8', puntajeSocNivel8.toString());

    return puntajeSocNivel8;
  }

  Future<int> getPuntajeCiudadanas9_firestore() async {
    int puntajeSocNivel9 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel9')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel9 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_9', puntajeSocNivel9.toString());

    return puntajeSocNivel9;
  }

  Future<int> getPuntajeCiudadanas10_firestore() async {
    int puntajeSocNivel10 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('ciudadanas')
        .collection('nivel10')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeSocNivel10 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_ciu_10', puntajeSocNivel10.toString());

    return puntajeSocNivel10;
  }

  //----------------------------- NATURALES ----------------------------------
  //funcion que busca el nivel 1, si existe, lo envia a shp para ser sumado a puntaje total
  Future<int> getPuntajeNat1_firestore() async {
    int puntajeNatNivel1 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel1')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel1 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_1', puntajeNatNivel1.toString());

    return puntajeNatNivel1;
  }

  Future<int> getPuntajeNat2_firestore() async {
    int puntajeNatNivel2 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel2')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel2 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_2', puntajeNatNivel2.toString());

    return puntajeNatNivel2;
  }

  Future<int> getPuntajeNat3_firestore() async {
    int puntajeNatNivel3 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel3')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel3 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_3', puntajeNatNivel3.toString());

    return puntajeNatNivel3;
  }

  Future<int> getPuntajeNat4_firestore() async {
    int puntajeNatNivel4 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel4')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel4 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_4', puntajeNatNivel4.toString());

    return puntajeNatNivel4;
  }

  Future<int> getPuntajeNat5_firestore() async {
    int puntajeNatNivel5 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel5')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel5 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_5', puntajeNatNivel5.toString());

    return puntajeNatNivel5;
  }

  Future<int> getPuntajeNat6_firestore() async {
    int puntajeNatNivel6 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel6')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel6 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_6', puntajeNatNivel6.toString());

    return puntajeNatNivel6;
  }

  Future<int> getPuntajeNat7_firestore() async {
    int puntajeNatNivel7 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel7')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel7 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_7', puntajeNatNivel7.toString());

    return puntajeNatNivel7;
  }

  Future<int> getPuntajeNat8_firestore() async {
    int puntajeNatNivel8 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel8')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel8 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_8', puntajeNatNivel8.toString());

    return puntajeNatNivel8;
  }

  Future<int> getPuntajeNat9_firestore() async {
    int puntajeNatNivel9 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel9')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel9 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_9', puntajeNatNivel9.toString());

    return puntajeNatNivel9;
  }

  Future<int> getPuntajeNat10_firestore() async {
    int puntajeNatNivel10 =
        0; // Inicializar la variable con un valor predeterminado en caso de que no haya datos

    final docSnapshot = await FirebaseFirestore.instance
        .collection('puntajes')
        .doc('naturales')
        .collection('nivel10')
        .doc(user!.uid)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('puntaje')) {
        puntajeNatNivel10 = data['puntaje'] as int;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('puntaje_naturales_10', puntajeNatNivel10.toString());

    return puntajeNatNivel10;
  }

  LocalStorage localStorage = LocalStorage();
  late SharedPreferences prefs;

  getDataSharedPreferences() async {
    //get name, module, tecnica
    getUserInfo();
    try {
      //obtener puntaje mat
      getScoreMatShp();
      getScoreIngShp();
      getScoreNatShp();
      getScoreCiuShp();
      getScoreLecShp();
    } catch (error) {
      print('ERROR EN GETDATASHAREDPREFERENCES: $error');
    }
  }

  String nameUserShp = '';
  String avatarUserShp = '';

  getUserInfo() async {
    nameUserShp = prefs.getString('nameUser') ?? 'no user';
    avatarUserShp = prefs.getString('avatarUser') ?? 'no avatar';

    print('IMPRIMIENTO AVATAR USER EN INIT EN GETUSER INFO: $avatarUserShp');

    setState(() {
      // Actualizar el estado aquí con los valores obtenidos
    });
  }

  int matScoresShp = 0;
  getScoreMatShp() async {
    //invoco la realizacion de la sumatoria de puntajes mat
    localStorage.getMatScores();

    //obtiene la anterior sumatoria realizada
    prefs = await SharedPreferences.getInstance();
    matScoresShp = prefs.getInt('scoreTotalMat') ?? 0;

    print('imprimiendo matScoresSHP: $matScoresShp');
  }

  int natScoresShp = 0;
  getScoreNatShp() async {
    //invoco la realizacion de la sumatoria de puntajes nat
    localStorage.getNatScores();

    //obtiene la anterior sumatoria realizada
    setState(() async {
      prefs = await SharedPreferences.getInstance();
      natScoresShp = prefs.getInt('scoreTotalNat') ?? 0;
    });

    print('imprimiendo natScoresSHP: $natScoresShp');
  }

  int ingScoresShp = 0;
  getScoreIngShp() async {
    //invoco la realizacion de la sumatoria de puntajes mat
    localStorage.getIngScores();

    //obtiene la anterior sumatoria realizada
    setState(() async {
      prefs = await SharedPreferences.getInstance();
      ingScoresShp = prefs.getInt('scoreTotalIng') ?? 0;
    });

    print('imprimiendo ingScoresSHP: $ingScoresShp');
  }

  int lecScoresShp = 0;
  getScoreLecShp() async {
    //invoco la realizacion de la sumatoria de puntajes mat
    localStorage.getLecScores();

    //obtiene la anterior sumatoria realizada
    setState(() async {
      prefs = await SharedPreferences.getInstance();
      lecScoresShp = prefs.getInt('scoreTotalLec') ?? 0;
    });

    print('imprimiendo lecScoresSHP: $lecScoresShp');
  }

  int ciuScoresShp = 0;
  getScoreCiuShp() async {
    //invoco la realizacion de la sumatoria de puntajes mat
    localStorage.getCiuScores();

    //obtiene la anterior sumatoria realizada
    setState(() async {
      prefs = await SharedPreferences.getInstance();
      ciuScoresShp = prefs.getInt('scoreTotalCiu') ?? 0;
    });

    print('imprimiendo lecScoresSHP: $ciuScoresShp');
  }

  @override
  Widget build(BuildContext context) {
    getButtonEnabled();
    _getAvatarFromSharedPrefs();
    final double totalWidth = MediaQuery.of(context).size.width;
    final double cellWidth = (totalWidth - 16) / 3;
    final double cellHeight = 40 / 3 * cellWidth;

    getScoreMatShp();
    getDataSharedPreferences();

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

              //banner
              ShakeWidgetY(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/banner_user.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.030,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 5, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(11, 0, 8, 0),
                                    child: Text(
                                      nameUserShp,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'BubblegumSans',
                                        fontSize:
                                            nameUserShp.length > 27 ? 10 : 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _modulo,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //img avatar
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.18,
                                height:
                                    MediaQuery.of(context).size.height * 0.070,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    width: cellWidth,
                                    height: cellHeight,
                                    child: CachedNetworkImage(
                                      imageUrl: avatarUserShp,
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

                            //puntaje total
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Puntaje total",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'BubblegumSans',
                                          fontSize: 13),
                                    ),
                                    Text(
                                      _modulo == 'Razonamiento Cuantitativo'
                                          ? "$matScoresShp"
                                          : _modulo == 'Inglés'
                                              ? "$ingScoresShp"
                                              : _modulo == 'Lectura Crítica'
                                                  ? "$lecScoresShp"
                                                  : _modulo ==
                                                          'Ciencias Naturales'
                                                      ? "$natScoresShp"
                                                      : _modulo ==
                                                              'Competencias Ciudadanas'
                                                          ? "$ciuScoresShp"
                                                          : "no module",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'BubblegumSans',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // btn 10
              Positioned(
                right: MediaQuery.of(context).size.width * 0.325,
                top: MediaQuery.of(context).size.height * 0.135,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      //Establece la imagen del boton - blocked || habilitado
                      child: GestureDetector(
                        child: niv10enabled ? button10 : buttonDisable,
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 40,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv10enabled == true) {
                              button10 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv10enabled == true) {
                              button10 = buttonUnpressed;
                              showDialogLevel(10, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv10enabled
                              ? const Text(
                                  '10',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv9enabled ? button9 : buttonDisable,
                    ),
                    Positioned(
                      top: 12,
                      left: 25,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv9enabled == true) {
                              button9 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv9enabled == true) {
                              button9 = buttonUnpressed;
                              showDialogLevel(9, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv9enabled
                              ? const Text(
                                  '9',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv8enabled ? button8 : buttonDisable,
                    ),
                    Positioned(
                      top: 15,
                      left: 28,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv8enabled == true) {
                              button8 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv8enabled == true) {
                              button8 = buttonUnpressed;
                              showDialogLevel(8, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv8enabled
                              ? const Text(
                                  '8',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv7enabled ? button7 : buttonDisable,
                    ),
                    Positioned(
                      top: 16,
                      left: 30,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv7enabled == true) {
                              button7 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv7enabled == true) {
                              button7 = buttonUnpressed;
                              showDialogLevel(7, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv7enabled
                              ? const Text(
                                  '7',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv6enabled ? button6 : buttonDisable,
                    ),
                    Positioned(
                      top: 17,
                      left: 32,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv6enabled == true) {
                              button6 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv6enabled == true) {
                              button6 = buttonUnpressed;
                              showDialogLevel(6, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv6enabled
                              ? const Text(
                                  '6',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv5enabled ? button5 : buttonDisable,
                    ),
                    Positioned(
                      top: 16,
                      left: 32,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv5enabled == true) {
                              button5 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv5enabled == true) {
                              button5 = buttonUnpressed;
                              showDialogLevel(5, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv5enabled
                              ? const Text(
                                  '5',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv4enabled ? button4 : buttonDisable,
                    ),
                    Positioned(
                      top: 16,
                      left: 30,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv4enabled == true) {
                              button4 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv4enabled == true) {
                              button4 = buttonUnpressed;
                              showDialogLevel(4, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv4enabled
                              ? const Text(
                                  '4',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv3enabled ? button3 : buttonDisable,
                    ),
                    Positioned(
                      top: 17,
                      left: 43,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv3enabled == true) {
                              button3 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv3enabled == true) {
                              button3 = buttonUnpressed;
                              showDialogLevel(3, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv3enabled
                              ? const Text(
                                  '3',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
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
                      child: niv2enabled ? button2 : buttonDisable,
                    ),
                    Positioned(
                      top: 19,
                      left: 38,
                      child: GestureDetector(
                        onTapDown: (tap) {
                          setState(() {
                            if (niv2enabled == true) {
                              button2 = buttonPressed;
                            }
                          });
                        },
                        onTapUp: (tap) {
                          setState(() {
                            if (niv2enabled == true) {
                              button2 = buttonUnpressed;
                              showDialogLevel(2, _modulo);
                            }
                          });
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: niv2enabled
                              ? const Text(
                                  '2',
                                  style: TextStyle(
                                    color: colors_colpaner.claro,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 25,
                                  ),
                                )
                              : const Text(
                                  '',
                                ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

/*               //btn inicial 1
              Positioned(
                left: MediaQuery.of(context).size.width * 0.375,
                bottom: MediaQuery.of(context).size.height * 0.028,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.145,
                      width: MediaQuery.of(context).size.width * 0.32,
                      child: GestureDetector(
                        child: button1,
                      ),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.030,
                        left: MediaQuery.of(context).size.width * 0.14,
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
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: colors_colpaner.claro,
                                fontFamily: 'BubblegumSans',
                                fontSize: 40,
                              ),
                            ),
                          ),
                        )),
                  ]),
                ),
              ),
 */
              // btn 1
              Positioned(
                left: MediaQuery.of(context).size.width * 0.375,
                bottom: MediaQuery.of(context).size.height * 0.028,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        //Establece la imagen del boton - blocked || habilitado
                        child: GestureDetector(
                          child: button1,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.030,
                        left: MediaQuery.of(context).size.width * 0.13,
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
                      ),
                    ],
                  ),
                ),
              ),

              //btn regresar
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: ShakeWidgetX(
                    child: IconButton(
                      icon: Image.asset('assets/flecha_left.png'),
                      iconSize: 30,
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
                                                    'En este nivel tendrás que girar una ruleta que contiene algunos temas que evalua el icfes en el modulo de $modulo.\n\nDeberás definir el concepto con tus palabras',
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
