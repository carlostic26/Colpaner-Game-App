import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  Future<int?> getPuntajesMat() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt('puntajes_MAT');
  }
}
