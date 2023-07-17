part of simulacro;

class OptionsWidget extends StatelessWidget {
  final question_model question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  //devuelve graficamente las opciones de respuestas en pantalla
  @override
  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    final optionIndex = question.options.indexOf(option);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: (option.text.length >= 0 && option.text.length <= 52) //1 linea
            ? MediaQuery.of(context).size.height * 0.045
            : (option.text.length >= 53 && option.text.length <= 100) //2 lineas
                ? MediaQuery.of(context).size.height * 0.062
                : option.text.length >= 101 &&
                        option.text.length <= 150 //3 lineas
                    ? 95
                    : option.text.length >= 151 &&
                            option.text.length <= 180 //4 lineas
                        ? 125
                        : option.text.length >= 181 &&
                                option.text.length <= 202 //4 lineas
                            ? 135
                            : option.text.length >= 203 &&
                                    option.text.length <= 230 //4 lineas
                                ? 150
                                : 200,
        padding: const EdgeInsets.fromLTRB(3, 1, 1, 1),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          //color of cards options
          color: colors_colpaner.oscuro, //189, 40, 13
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${String.fromCharCode(65 + optionIndex)}.", // A, B, C, D
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'ZCOOL',
                    fontSize: 12.0),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  option.text, // "${option.text.length}${option.text}",
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'ZCOOL', fontSize: 12.0),
                ),
              ),
              //getIconForOption(option, question)
            ],
          ),
        ),
      ),
    );
  }

//Método que devuelve un color como forma de validación de respuesta por el usuario
  Color getColorForOption(Option option, question_model question) {
    final isSelected = option == question.selectedOption;

    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.amber : Colors.amber;
      }
    }

    return Colors.grey.shade300;
  }

/*   Widget getIconForOption(Option option, question_model question) {
    final isSelect = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelect) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.orange);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  } */
}
