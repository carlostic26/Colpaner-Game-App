import 'package:flutter/cupertino.dart';

Widget figureImage(bool visible, String path) {
  return Visibility(
      visible: visible,
      child: SizedBox(
        width: 300,
        height: 210,
        child: Image.asset(path),
      ));
}
