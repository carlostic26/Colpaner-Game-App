import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/vista/screens/drawer.dart';

import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';

class UsabilidadScreen extends StatefulWidget {
  const UsabilidadScreen({super.key});

  @override
  State<UsabilidadScreen> createState() => _UsabilidadScreenState();
}

class _UsabilidadScreenState extends State<UsabilidadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Usabilidad",
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
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 120,
                width: 120,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiObUamKYL3kEUaqztoQq3GS5BN4reaPkHEmewms-2W6D5rNCvgZayv-dwYPPpcdTTe3U6uxpPb0si2PH28gAjqaBVP75jwuolg_XXaHWuR_-1xg-vkaCK0U9Ep5MLpKJXNPDPx8A2p5peo7H64pf8nZFg2lnD9WwEFeFtB5u_K5qXCuqrXav6dPEnKBA/s320/logo%20colpaner%20game%20app%20png.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "La aplicación Colpaner Game App está diseñada para ayudar a los estudiantes a prepararse para el examen ICFES SABER 11 de manera lúdica y entretenida. Con 10 niveles de dificultad creciente, cada uno con diferentes minijuegos relacionados con las áreas evaluadas en el examen, los usuarios pueden mejorar sus habilidades y aumentar su confianza en su rendimiento académico. \n\nCada nivel está diseñado para desafiar al usuario y ayudarlo a mejorar su comprensión de los temas. Los minijuegos son amigables y divertidos, y están diseñados para ser una experiencia educativa enriquecedora. \n\nEl último nivel es un simulacro del examen ICFES con tiempo contabilizado, para que los usuarios puedan experimentar cómo sería el examen real y evaluar su rendimiento. \n\nLa aplicación también ofrece un sistema de puntajes para que los usuarios puedan medir su progreso y competir contra otros usuarios. \n\nColpaner Game App es una herramienta valiosa para cualquier estudiante que busque mejorar su rendimiento académico y prepararse para el examen ICFES SABER 11 de manera eficente y divertida.",
                style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    fontSize: 17,
                    color: colors_colpaner.claro),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerColpaner(
        context: context,
        screen: 'usabilidad',
      ),
    );
  }
}
