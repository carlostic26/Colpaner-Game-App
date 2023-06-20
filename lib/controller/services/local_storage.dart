import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    //recibe el sharedPreferences como instancias necesarias para leer al momento de abrir la app
    prefs = await SharedPreferences.getInstance();
  }

  Future<int?> getPuntajesMat() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getInt('puntajes_MAT');
  }

  // LEVEL 1
  Future<bool?> setMatBtn1Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_1_unlocked', true);
  }

  Future<bool?> setIngBtn1Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_1_unlocked', true);
  }

  Future<bool?> setLecBtn1Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_1_unlocked', true);
  }

  Future<bool?> setNatBtn1Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_1_unlocked', true);
  }

  Future<bool?> setCiuBtn1Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_1_unlocked', true);
  }

// LEVEL 2
  Future<bool?> setMatBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_2_unlocked', true);
  }

  Future<bool?> setIngBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_2_unlocked', true);
  }

  Future<bool?> setLecBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_2_unlocked', true);
  }

  Future<bool?> setNatBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_2_unlocked', true);
  }

  Future<bool?> setCiuBtn2Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_2_unlocked', true);
  }

// LEVEL 3
  Future<bool?> setMatBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_3_unlocked', true);
  }

  Future<bool?> setIngBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_3_unlocked', true);
  }

  Future<bool?> setLecBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_3_unlocked', true);
  }

  Future<bool?> setNatBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_3_unlocked', true);
  }

  Future<bool?> setCiuBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_3_unlocked', true);
  }

// LEVEL 4
  Future<bool?> setMatBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_4_unlocked', true);
  }

  Future<bool?> setIngBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_4_unlocked', true);
  }

  Future<bool?> setLecBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_4_unlocked', true);
  }

  Future<bool?> setNatBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_4_unlocked', true);
  }

  Future<bool?> setCiuBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_4_unlocked', true);
  }

// LEVEL 5
  Future<bool?> setMatBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_5_unlocked', true);
  }

  Future<bool?> setIngBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_5_unlocked', true);
  }

  Future<bool?> setLecBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_5_unlocked', true);
  }

  Future<bool?> setNatBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_5_unlocked', true);
  }

  Future<bool?> setCiuBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_5_unlocked', true);
  }

// LEVEL 6

  Future<bool?> setMatBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_6_unlocked', true);
  }

  Future<bool?> setIngBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_6_unlocked', true);
  }

  Future<bool?> setLecBtn61Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_6_unlocked', true);
  }

  Future<bool?> setNatBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_6_unlocked', true);
  }

  Future<bool?> setCiuBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_6_unlocked', true);
  }

// LEVEL 7

  Future<bool?> setMatBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_7_unlocked', true);
  }

  Future<bool?> setIngBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_7_unlocked', true);
  }

  Future<bool?> setLecBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_7_unlocked', true);
  }

  Future<bool?> setNatBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_7_unlocked', true);
  }

  Future<bool?> setCiuBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_7_unlocked', true);
  }

// LEVEL 8

  Future<bool?> setMatBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_8_unlocked', true);
  }

  Future<bool?> setIngBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_8_unlocked', true);
  }

  Future<bool?> setLecBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_8_unlocked', true);
  }

  Future<bool?> setNatBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_8_unlocked', true);
  }

  Future<bool?> setCiuBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_8_unlocked', true);
  }

// LEVEL 9
  Future<bool?> setMatBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_9_unlocked', true);
  }

  Future<bool?> setIngBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_9_unlocked', true);
  }

  Future<bool?> setLecBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_9_unlocked', true);
  }

  Future<bool?> setNatBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_9_unlocked', true);
  }

  Future<bool?> setCiuBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_9_unlocked', true);
  }

//LEVEL 10

  Future<bool?> setMatBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_btn_10_unlocked', true);
  }

  Future<bool?> setIngBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ing_10_unlocked', true);
  }

  Future<bool?> setLecBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_lec_10_unlocked', true);
  }

  Future<bool?> setNatBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_nat_10_unlocked', true);
  }

  Future<bool?> setCiuBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('mat_ciu_10_unlocked', true);
  }
}
