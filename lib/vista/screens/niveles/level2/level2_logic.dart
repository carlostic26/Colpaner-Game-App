class GameCards {
  final String hiddenCardpath =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhIZ0BeUdFWmKEPuHG8oqYPvKvLKbqVNHuiatUdPUCTvlDPUqsGPOjlf-O0VLFKGn1ThkIRpjtJ1xlKFp0q9SMG0pMtdsERgeKUGmOZCxkdgxr_zbyPhJQofnGHIy3jsYoNjp66DeodhoFnRC66yvzxsI9QsE_9lj2SqinF8T9TEMG7N8SYZ08Sb5w/s320/icon.png';
  List<String>? gameImg;

  final List<String> cards_list_lec = [
    "Los estudiantes aplican estrategias: identificación de argumentos, evaluación de evidencia y detección de sesgos.",
    "Lectura Crítica evalúa capacidad de análisis y razonamiento crítico con textos de diversa temática.",
    "Estudiantes infieren e interpretan información precisa en Lectura Crítica del ICFES Saber 11.",
    "Identificar idea principal y detalles es fundamental en Lectura Crítica para el éxito.",
    "Lectura Crítica desarrolla habilidades avanzadas y pensamiento crítico para educación superior.",
    "Estudiantes relacionan información y evalúan argumentos en Lectura Crítica del ICFES Saber 11.",
    //
    "Los estudiantes aplican estrategias: identificación de argumentos, evaluación de evidencia y detección de sesgos.",
    "Lectura Crítica evalúa capacidad de análisis y razonamiento crítico con textos de diversa temática.",
    "Estudiantes infieren e interpretan información precisa en Lectura Crítica del ICFES Saber 11.",
    "Identificar idea principal y detalles es fundamental en Lectura Crítica para el éxito.",
    "Lectura Crítica desarrolla habilidades avanzadas y pensamiento crítico para educación superior.",
    "Estudiantes relacionan información y evalúan argumentos en Lectura Crítica del ICFES Saber 11."
  ];

  final List<String> cards_list_mat = [
    "El Razonamiento Cuantitativo es la resolución de problemas matemáticos.",
    "Habilidades numéricas y algebraicas en el módulo de Matemáticas.",
    "Interpretación de datos y gráficos en Razonamiento Cuantitativo.",
    "Aplicación de fórmulas y conceptos matemáticos en el examen.",
    "Resolución de ecuaciones y sistemas de ecuaciones en Matemáticas.",
    "Uso de estrategias y razonamiento lógico en el módulo de Razonamiento Cuantitativo.",
    //
    "El Razonamiento Cuantitativo es la resolución de problemas matemáticos.",
    "Habilidades numéricas y algebraicas en el módulo de Matemáticas.",
    "Interpretación de datos y gráficos en Razonamiento Cuantitativo.",
    "Aplicación de fórmulas y conceptos matemáticos en el examen.",
    "Resolución de ecuaciones y sistemas de ecuaciones en Matemáticas.",
    "Uso de estrategias y razonamiento lógico en el módulo de Razonamiento Cuantitativo."
  ];

  final List<String> cards_list_ing = [
    "Identificar errores y elegir opción correcta",
    "Habilidades lingüísticas en el examen de Inglés del ICFES.",
    "Interpretación de textos y diálogos en el módulo de Inglés.",
    "Vocabulario y gramática en el módulo de Inglés del ICFES Saber 11.",
    "Conocimiento de vocabulario en el examen de Inglés del ICFES.",
    "Uso de estrategias de comprensión y análisis en el módulo de Inglés.",
//
    "Identificar errores y elegir opción correcta",
    "Habilidades lingüísticas en el examen de Inglés del ICFES.",
    "Interpretación de textos y diálogos en el módulo de Inglés.",
    "Vocabulario y gramática en el módulo de Inglés del ICFES Saber 11.",
    "Conocimiento de vocabulario en el examen de Inglés del ICFES.",
    "Uso de estrategias de comprensión y análisis en el módulo de Inglés."
  ];

  final List<String> cards_list_comp = [
    "Competencias Ciudadanas: conocimiento de derechos y deberes ciudadanos.",
    "Desarrollo de habilidades de resolución de conflictos en el examen.",
    "Comprensión de la participación ciudadana y la democracia.",
    "Ética y valores en el módulo de Competencias Ciudadanas.",
    "Conocimiento sobre diversidad cultural y respeto a los demás.",
    "Habilidades de pensamiento crítico y análisis de problemas sociales.",
//
    "Competencias Ciudadanas: conocimiento de derechos y deberes ciudadanos.",
    "Desarrollo de habilidades de resolución de conflictos en el examen.",
    "Comprensión de la participación ciudadana y la democracia.",
    "Ética y valores en el módulo de Competencias Ciudadanas.",
    "Conocimiento sobre diversidad cultural y respeto a los demás.",
    "Habilidades de pensamiento crítico y análisis de problemas sociales."
  ];

  final List<String> cards_list_nat = [
    "Interpretación de fenómenos y procesos naturales en Ciencias Naturales.",
    "Aplicación de conocimientos científicos en la resolución de problemas.",
    "Comprensión de conceptos y principios fundamentales de Ciencias Naturales.",
    "Análisis e interpretación de datos científicos y gráficos.",
    "Conocimiento sobre la diversidad de los seres vivos y su interacción con el entorno.",
    "Habilidades de pensamiento crítico y análisis en el módulo de Ciencias Naturales.",
    "Interpretación de fenómenos y procesos naturales en Ciencias Naturales.",
    "Aplicación de conocimientos científicos en la resolución de problemas.",
    "Comprensión de conceptos y principios fundamentales de Ciencias Naturales.",
    "Análisis e interpretación de datos científicos y gráficos.",
    "Conocimiento sobre la diversidad de los seres vivos y su interacción con el entorno.",
    "Habilidades de pensamiento crítico y análisis en el módulo de Ciencias Naturales."
  ];

  // en esta lista guardaremos las dos primeras cartas tocadas y validar si son compatibles o no
  List<Map<int, String>> matchCheck = [];

  final int cardCount = 12;

  void initGame() {
    cards_list_mat.shuffle(); // reorganiza las premisas aleatoriamente
    cards_list_ing.shuffle(); // reorganiza las premisas aleatoriamente
    cards_list_lec.shuffle(); // reorganiza las premisas aleatoriamente
    cards_list_nat.shuffle(); // reorganiza las premisas aleatoriamente
    cards_list_comp.shuffle(); // reorganiza las premisas aleatoriamente
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
