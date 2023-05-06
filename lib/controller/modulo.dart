//guarda el modulo ingresado en sharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

void setModulo(modulo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('modulo', modulo);
}

//recibe el modulo guardado anteriormente en sharedPreferences
Future<String> getModulo() async {
  final prefs = await SharedPreferences.getInstance();

  String modulo = prefs.getString('modulo') ?? '';
  return modulo;
}
