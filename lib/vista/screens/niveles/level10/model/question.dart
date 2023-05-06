part of simulacro;

class Question {
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['pregunta'],
      options: [
        Option(text: map['opcion1'], isCorrect: map['respuesta1'] == 1),
        Option(text: map['opcion2'], isCorrect: map['respuesta2'] == 1),
        Option(text: map['opcion3'], isCorrect: map['respuesta3'] == 1),
        Option(text: map['opcion4'], isCorrect: map['respuesta4'] == 1),
      ],
      imagen: map['imagen'],
    );
  }

  late final String text;
  late final List<Option> options;
  late final String imagen;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    required this.imagen,
    this.isLocked = false,
    this.selectedOption,
  });
}
