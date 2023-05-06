import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class level9 extends StatefulWidget {
  const level9({super.key});

  @override
  State<level9> createState() => _level9State();
}

class _level9State extends State<level9> {
  final List<String> words = ['FLUTTER', 'DART'];

  @override
  Widget build(BuildContext context) {
    List<Widget> cells = [];

    for (var i = 0; i < 100; i++) {
      var letter = '';
      if (i == 1 ||
          i == 2 ||
          i == 3 ||
          i == 4 ||
          i == 5 ||
          i == 6 ||
          i == 7 ||
          i == 8) {
        letter = words[0][i - 1];
      } else if (i == 11 ||
          i == 21 ||
          i == 31 ||
          i == 41 ||
          i == 51 ||
          i == 61 ||
          i == 71 ||
          i == 81) {
        letter = words[1][(i - 11) ~/ 10];
      }

      cells.add(Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ));
    }

    return GridView.count(
      crossAxisCount: 10, // número de columnas
      children: cells,
    );
  }
}
