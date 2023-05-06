import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';

Widget letter(String character, bool hidden) {
  return Container(
    height: 50,
    width: 35,
    padding: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      color: colors_colpaner.oscuro, //color red dark
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Visibility(
      visible: !hidden,
      child: Center(
        child: Text(
          //color text pinted word
          character,
          style: const TextStyle(
            color: colors_colpaner.claro,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            fontFamily: 'BubblegumSans',
          ),
        ),
      ),
    ),
  );
}
