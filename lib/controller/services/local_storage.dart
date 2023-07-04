import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  //guarda el modulo ingresado en sharedPreferences
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

  static Future<void> configurePrefs() async {
    //recibe el sharedPreferences como instancias necesarias para leer al momento de abrir la app
    prefs = await SharedPreferences.getInstance();
  }

  Future<int?> getPuntajesMat() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt('puntajes_MAT');
  }

  // MAT BTN GET

  Future<bool?> getMatBtn2Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled2') ?? false;
  }

  Future<bool?> getMatBtn3Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled3') ?? false;
  }

  Future<bool?> getMatBtn4Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled4') ?? false;
  }

  Future<bool?> getMatBtn5Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled5') ?? false;
  }

  Future<bool?> getMatBtn6Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled6') ?? false;
  }

  Future<bool?> getMatBtn7Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled7') ?? false;
  }

  Future<bool?> getMatBtn8Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled8') ?? false;
  }

  Future<bool?> getMatBtn9Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled9') ?? false;
  }

  Future<bool?> getMatBtn10Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('mat_enabled10') ?? false;
  }

  //MAT BTN SET

  Future<bool?> setMatBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled2', true);
  }

  Future<bool?> setMatBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled3', true);
  }

  Future<bool?> setMatBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled4', true);
  }

  Future<bool?> setMatBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled5', true);
  }

  Future<bool?> setMatBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled6', true);
  }

  Future<bool?> setMatBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled7', true);
  }

  Future<bool?> setMatBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled8', true);
  }

  Future<bool?> setMatBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled9', true);
  }

  Future<bool?> setMatBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_enabled10', true);
  }

  //INGLES GET
  Future<bool?> getIngBtn2Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled2') ?? false;
  }

  Future<bool?> getIngBtn3Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled3') ?? false;
  }

  Future<bool?> getIngBtn4Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled4') ?? false;
  }

  Future<bool?> getIngBtn5Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled5') ?? false;
  }

  Future<bool?> getIngBtn6Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled6') ?? false;
  }

  Future<bool?> getIngBtn7Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled7') ?? false;
  }

  Future<bool?> getIngBtn8Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled8') ?? false;
  }

  Future<bool?> getIngBtn9Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled9') ?? false;
  }

  Future<bool?> getIngBtn10Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ing_enabled10') ?? false;
  }

  //INGLES SET

  Future<bool?> setIngBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled2', true);
  }

  Future<bool?> setIngBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled3', true);
  }

  Future<bool?> setIngBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled4', true);
  }

  Future<bool?> setIngBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled5', true);
  }

  Future<bool?> setIngBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled6', true);
  }

  Future<bool?> setIngBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled7', true);
  }

  Future<bool?> setIngBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled8', true);
  }

  Future<bool?> setIngBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled9', true);
  }

  Future<bool?> setIngBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ing_enabled10', true);
  }

  //NATURALES GET

  Future<bool?> getNatBtn2Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled2') ?? false;
  }

  Future<bool?> getNatBtn3Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled3') ?? false;
  }

  Future<bool?> getNatBtn4Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled4') ?? false;
  }

  Future<bool?> getNatBtn5Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled5') ?? false;
  }

  Future<bool?> getNatBtn6Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled6') ?? false;
  }

  Future<bool?> getNatBtn7Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled7') ?? false;
  }

  Future<bool?> getNatBtn8Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled8') ?? false;
  }

  Future<bool?> getNatBtn9Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled9') ?? false;
  }

  Future<bool?> getNatBtn10Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('nat_enabled10') ?? false;
  }

  //NATURALES SET

  Future<bool?> setNatBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled2', true);
  }

  Future<bool?> setNatBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled3', true);
  }

  Future<bool?> setNatBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled4', true);
  }

  Future<bool?> setNatBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled5', true);
  }

  Future<bool?> setNatBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled6', true);
  }

  Future<bool?> setNatBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled7', true);
  }

  Future<bool?> setNatBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled8', true);
  }

  Future<bool?> setNatBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled9', true);
  }

  Future<bool?> setNatBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('nat_enabled10', true);
  }

  //CIUDADANAS GET

  Future<bool?> getCiuBtn2Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled2') ?? false;
  }

  Future<bool?> getCiuBtn3Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled3') ?? false;
  }

  Future<bool?> getCiuBtn4Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled4') ?? false;
  }

  Future<bool?> getCiuBtn5Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled5') ?? false;
  }

  Future<bool?> getCiuBtn6Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled6') ?? false;
  }

  Future<bool?> getCiuBtn7Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled7') ?? false;
  }

  Future<bool?> getCiuBtn8Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled8') ?? false;
  }

  Future<bool?> getCiuBtn9Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled9') ?? false;
  }

  Future<bool?> getCiuBtn10Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ciu_enabled10') ?? false;
  }

  //CIUDADANAS SET

  Future<bool?> setCiuBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled2', true);
  }

  Future<bool?> setCiuBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled3', true);
  }

  Future<bool?> setCiuBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled4', true);
  }

  Future<bool?> setCiuBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled5', true);
  }

  Future<bool?> setCiuBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled6', true);
  }

  Future<bool?> setCiuBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled7', true);
  }

  Future<bool?> setCiuBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled8', true);
  }

  Future<bool?> setCiuBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled9', true);
  }

  Future<bool?> setCiuBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled10', true);
  }

  //LECTURA GET

  Future<bool?> getLecBtn2Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled2') ?? false;
  }

  Future<bool?> getLecBtn3Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled3') ?? false;
  }

  Future<bool?> getLecBtn4Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled4') ?? false;
  }

  Future<bool?> getLecBtn5Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled5') ?? false;
  }

  Future<bool?> getLecBtn6Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled6') ?? false;
  }

  Future<bool?> getLecBtn7Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled7') ?? false;
  }

  Future<bool?> getLecBtn8Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled8') ?? false;
  }

  Future<bool?> getLecBtn9Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled9') ?? false;
  }

  Future<bool?> getLecBtn10Enabled() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lec_enabled10') ?? false;
  }

  //LECTURA SET

  Future<bool?> setLecBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled2', true);
  }

  Future<bool?> setLecBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled3', true);
  }

  Future<bool?> setLecBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled4', true);
  }

  Future<bool?> setLecBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled5', true);
  }

  Future<bool?> setLecBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled6', true);
  }

  Future<bool?> setLecBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled7', true);
  }

  Future<bool?> setLecBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled8', true);
  }

  Future<bool?> setLecBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled9', true);
  }

  Future<bool?> setLecBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ciu_enabled10', true);
  }

  //NATURALES GET

  //NATURALES SET
}
