library simulacro;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';

import 'package:gamicolpaner/controller/services/customStyle.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/dbexam.dart';
import 'package:gamicolpaner/model/question_list_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'result_page_simulacro.dart';
part 'model/question_widget.dart';
part 'model/options_widget.dart';
part 'model/question.dart';
part 'model/option.dart';

/*NIVEL TIPO QUIZ 
  Este nivel consiste en desplegar diferentes tipos de preguntas
  El jugador deberá seleccionar una de las opciones.

  El sistema validará la respuesta seleccionada a traves de un aviso sobre la respuesta.

*/

class simulacro extends StatefulWidget {
  const simulacro({Key? key}) : super(key: key);

  @override
  State<simulacro> createState() => _simulacroState();
}

class _simulacroState extends State<simulacro> {
  // Variables para el contador
  int _secondsLeft = 300;
  Timer? _timer;

  String _message = "";
  int _timeLeft = 6;

  //llamando la clase question para conectar sqflite
  SimulacroHandler handler = SimulacroHandler();
  Future<List<question_model>>? _questions;

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
          switch (_timeLeft) {
            case 4:
              _message = "¡Sabemos que lo lograrás!";
              break;
            case 3:
              _message = "3...";
              break;
            case 2:
              _message = "2...";
              break;
            case 1:
              _message = "1...";
              break;
            default:
              _message = "¿Preparado?";
          }
        });
        _startCountdown();
      } else {
        setState(() {
          _message = "¡Muchos éxitos!";
          _startTimer();
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _message = "";
          });
        });
      }
    });
  }

  String _modulo = '';

  @override
  void initState() {
    super.initState();
    _initializeHandler();
    _startCountdown();
    print('initState MODULO: ' + _modulo);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Detener el contador al salir de la pantalla
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft == 0) {
        _timer?.cancel();
        // Agregar aquí la acción que quieras realizar al agotarse el tiempo
      }
    });
  }

  Future<void> _initializeHandler() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });

    switch (_modulo) {
      case "Razonamiento Cuantitativo":
        {
          handler = SimulacroHandler();
          await handler.initializeDB();
          _questions = Future.value(await getListMAT());
        }
        break;

      case "Inglés":
        {
          handler = SimulacroHandler();
          await handler.initializeDB();
          _questions = Future.value(await getListING());
        }
        break;

      case "Lectura Crítica":
        {
          handler = SimulacroHandler();
          await handler.initializeDB();
          _questions = Future.value(await getListLEC());
        }
        break;

      case "Ciencias Naturales":
        {
          handler = SimulacroHandler();
          await handler.initializeDB();
          _questions = Future.value(await getListNAT());
        }
        break;

      case "Competencias Ciudadanas":
        {
          handler = SimulacroHandler();
          await handler.initializeDB();
          _questions = Future.value(await getListCIU());
        }
        break;
    }

    print('initializeHandler completed with MODULO: ' + _modulo);
  }

  int itemsIng = 0;

  Future<List<question_model>> getListING() async {
    Random random = Random();
    int randomIndex =
        random.nextInt(2); // Genera un número aleatorio entre 0 y 1

    List<question_model> dbQuestions;

    if (randomIndex == 0) {
      dbQuestions = await handler.queryING1();
    } else {
      dbQuestions = await handler.queryING2();
    }

    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  //Methods that receive the list select from dbhelper
  Future<List<question_model>> getListMAT() async {
    Random random = Random();
    int randomIndex =
        random.nextInt(2); // Genera un número aleatorio entre 0 y 1

    List<question_model> dbQuestions;

    if (randomIndex == 0) {
      dbQuestions = await handler.queryMAT1();
    } else {
      dbQuestions = await handler.queryMAT2();
    }
    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  //Methods that receive the list select from dbhelper
  Future<List<question_model>> getListLEC() async {
    Random random = Random();
    int randomIndex =
        random.nextInt(2); // Genera un número aleatorio entre 0 y 1

    List<question_model> dbQuestions;

    if (randomIndex == 0) {
      dbQuestions = await handler.queryLEC1();
    } else {
      dbQuestions = await handler.queryLEC2();
    }

    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  //Methods that receive the list select from dbhelper
  Future<List<question_model>> getListNAT() async {
    Random random = Random();
    int randomIndex =
        random.nextInt(2); // Genera un número aleatorio entre 0 y 1

    List<question_model> dbQuestions;

    if (randomIndex == 0) {
      dbQuestions = await handler.queryNAT1();
    } else {
      dbQuestions = await handler.queryNAT2();
    }

    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  //Methods that receive the list select from dbhelper
  Future<List<question_model>> getListCIU() async {
    Random random = Random();
    int randomIndex =
        random.nextInt(2); // Genera un número aleatorio entre 0 y 1

    List<question_model> dbQuestions;

    if (randomIndex == 0) {
      dbQuestions = await handler.queryCIU1();
    } else {
      dbQuestions = await handler.queryCIU2();
    }

    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  Future<void> _onRefresh() async {
    setState(() {
      switch (_modulo) {
        case "Razonamiento Cuantitativo":
          {
            _questions = getListMAT();
          }
          break;

        case "Inglés":
          {
            _questions = getListING();
          }
          break;
        case "Lectura Crítica":
          {
            _questions = getListLEC();
          }
          break;
        case "Ciencias Naturales":
          {
            _questions = getListNAT();
          }
          break;
        case "Competencias Ciudadanas":
          {
            _questions = getListCIU();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _questions != null
                    ? QuestionWidget(questions: _questions!)
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),

          // Contenedor para el contador
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${_secondsLeft ~/ 60}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          if (_message != "")
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      _message,
                      style: customTextStyle,
                    ),
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
