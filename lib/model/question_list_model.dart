import '../vista/screens/niveles/level10/simulacro.dart';

class question_model {
  final String modulo;
  final String pregunta;
  final List<Option> options;
  final String imagen;
  bool isLocked;
  Option? selectedOption;

  question_model({
    required this.modulo,
    required this.pregunta,
    required this.options,
    required this.imagen,
    this.isLocked = false,
    this.selectedOption,
  });

  Map<String, dynamic> toMap() {
    return {
      'modulo': modulo,
      'pregunta': pregunta,
      'resp_1': options[0].text,
      'resp_2': options[1].text,
      'resp_3': options[2].text,
      'resp_4': options[3].text,
      'op_1': options[0].isCorrect ? 1 : 0,
      'op_2': options[1].isCorrect ? 1 : 0,
      'op_3': options[2].isCorrect ? 1 : 0,
      'op_4': options[3].isCorrect ? 1 : 0,
      'imagen': imagen,
      'isLocked': isLocked,
      'selectedOption': selectedOption?.toMap(),
    };
  }

  factory question_model.fromMap(Map<String, dynamic> map) {
    return question_model(
      modulo: map['modulo'],
      pregunta: map['pregunta'],
      options: [
        Option(text: map['resp_1'].toString(), isCorrect: map['op_1'] == 1),
        Option(text: map['resp_2'].toString(), isCorrect: map['op_2'] == 1),
        Option(text: map['resp_3'].toString(), isCorrect: map['op_3'] == 1),
        Option(text: map['resp_4'].toString(), isCorrect: map['op_4'] == 1),
      ],
      imagen: map['imagen'],
      isLocked: map['isLocked'] ?? false,
      selectedOption: map['selectedOption'] != null
          ? Option.fromMap(map['selectedOption'])
          : null,
    );
  }
}


/*
class question_model {
  final String modulo;
  final String pregunta;
  final String resp_1;
  final String resp_2;
  final String resp_3;
  final String resp_4;
  final String op_1;
  final String op_2;
  final String op_3;
  final String op_4;
  final String imagen;


  question_model({
    required this.modulo,
    required this.pregunta,
    required this.resp_1,
    required this.resp_2,
    required this.resp_3,
    required this.resp_4,
    required this.op_1,
    required this.op_2,
    required this.op_3,
    required this.op_4,
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return {
      'modulo': modulo,
      'pregunta': pregunta,
      'resp_1': resp_1,
      'resp_2': resp_2,
      'resp_3': resp_3,
      'resp_4': resp_4,
      'op_1': op_1,
      'op_2': op_2,
      'op_3': op_3,
      'op_4': op_4,
      'imagen': imagen,
    };
  }

  question_model.fromMap(Map<String, dynamic> res)
      : modulo = res["modulo"],
        pregunta = res["pregunta"],
        resp_1 = res["resp_1"],
        resp_2 = res["resp_2"],
        resp_3 = res["resp_3"],
        resp_4 = res["resp_4"],
        op_1 = res["op_1"],
        op_2 = res["op_2"],
        op_3 = res["op_3"],
        op_4 = res["op_4"],
        imagen = res["imagen"];

  @override
  String toString() {
    return 'question_model{modulo: $modulo, pregunta: $pregunta, resp_1: $resp_1, resp_2: $resp_2, resp_3: $resp_3, resp_4: $resp_4, op_1: $op_1, op_2: $op_2, op_3: $op_3, op_4: $op_4, imagen: $imagen}';
  }
}


*/