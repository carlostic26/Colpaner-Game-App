import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';

Widget scoreBoard1(String title, String info) {
  //retorna un expanded como forma responsiva de visualizar el widget segun la pantalla
  return Container(
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
    decoration: BoxDecoration(
      color: colors_colpaner.claro,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: 'BubblegumSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Text(
          info,
          style: const TextStyle(
              fontFamily: 'BubblegumSans',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
