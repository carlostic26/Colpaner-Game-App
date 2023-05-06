import 'package:gamicolpaner/vista/dialogs/gameover.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/dialogs/gender_dialog.dart';

// es la clase de dialogo que conecta con la clase del menu
//cada dialogo se trabaja independiente respectivamente de cada modulo y nivel
//se recomienda un dialogo unico para todos los contexto para recibir un parametro como un argumento
class DialogHelper {
  static gender_dialog(context) =>
      showDialog(context: context, builder: (builder) => genderDialog());

  //Dialogos para Diseño

  //GameOver RC -- recibe un contexto y un puntaje
  static showDialogGameOver(context, score) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => ShowDialogGameOver(
            score: int.parse(score.toString()),
          ));
}
