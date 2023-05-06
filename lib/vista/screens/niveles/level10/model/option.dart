part of simulacro;

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      text: map['text'],
      isCorrect: map['isCorrect'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}
