//guarda el modulo ingresado en sharedPreferences
import 'package:shared_preferences/shared_preferences.dart';

int niv1MAT = 0,
    niv2MAT = 0,
    niv3MAT = 0,
    niv4MAT = 0,
    niv5MAT = 0,
    niv6MAT = 0,
    niv7MAT = 0,
    niv8MAT = 0,
    niv9MAT = 0,
    niv10MAT = 0;

int niv1ING = 0,
    niv2ING = 0,
    niv3ING = 0,
    niv4ING = 0,
    niv5ING = 0,
    niv6ING = 0,
    niv7ING = 0,
    niv8ING = 0,
    niv9ING = 0,
    niv10ING = 0;

int niv1LEC = 0,
    niv2LEC = 0,
    niv3LEC = 0,
    niv4LEC = 0,
    niv5LEC = 0,
    niv6LEC = 0,
    niv7LEC = 0,
    niv8LEC = 0,
    niv9LEC = 0,
    niv10LEC = 0;

int niv1SOC = 0,
    niv2SOC = 0,
    niv3SOC = 0,
    niv4SOC = 0,
    niv5SOC = 0,
    niv6SOC = 0,
    niv7SOC = 0,
    niv8SOC = 0,
    niv9SOC = 0,
    niv10SOC = 0;

int niv1CIU = 0,
    niv2CIU = 0,
    niv3CIU = 0,
    niv4CIU = 0,
    niv5CIU = 0,
    niv6CIU = 0,
    niv7CIU = 0,
    niv8CIU = 0,
    niv9CIU = 0,
    niv10CIU = 0;

int niv1NAT = 0,
    niv2NAT = 0,
    niv3NAT = 0,
    niv4NAT = 0,
    niv5NAT = 0,
    niv6NAT = 0,
    niv7NAT = 0,
    niv8NAT = 0,
    niv9NAT = 0,
    niv10NAT = 0;

Future<int> getPuntaje_MAT1() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_1') ?? '';
  niv1MAT = int.parse(score);
  return niv1MAT;
}

Future<int> getPuntaje_MAT2() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_2') ?? '';
  niv2MAT = int.parse(score);
  return niv2MAT;
}

Future<int> getPuntaje_MAT3() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_3') ?? '';
  niv3MAT = int.parse(score);
  return niv3MAT;
}

Future<int> getPuntaje_MAT4() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_4') ?? '';
  niv4MAT = int.parse(score);
  return niv4MAT;
}

Future<int> getPuntaje_MAT5() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_5') ?? '';
  niv5MAT = int.parse(score);
  return niv5MAT;
}

Future<int> getPuntaje_MAT6() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_6') ?? '';
  niv6MAT = int.parse(score);
  return niv6MAT;
}

Future<int> getPuntaje_MAT7() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_7') ?? '';
  niv7MAT = int.parse(score);
  return niv7MAT;
}

Future<int> getPuntaje_MAT8() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_8') ?? '';
  niv8MAT = int.parse(score);
  return niv8MAT;
}

Future<int> getPuntaje_MAT9() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_9') ?? '';
  niv9MAT = int.parse(score);
  return niv9MAT;
}

Future<int> getPuntaje_MAT10() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_mat_10') ?? '';
  niv10MAT = int.parse(score);
  return niv10MAT;
}

//INGLES -----------------------------------------------------

Future<int> getPuntaje_ING1() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_1') ?? '';
  niv1ING = int.parse(score);
  return niv1ING;
}

Future<int> getPuntaje_ING2() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_2') ?? '';
  niv2ING = int.parse(score);
  return niv2ING;
}

Future<int> getPuntaje_ING3() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_3') ?? '';
  niv3ING = int.parse(score);
  return niv3ING;
}

Future<int> getPuntaje_ING4() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_4') ?? '';
  niv4ING = int.parse(score);
  return niv4ING;
}

Future<int> getPuntaje_ING5() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_5') ?? '';
  niv5ING = int.parse(score);
  return niv5ING;
}

Future<int> getPuntaje_ING6() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_6') ?? '';
  niv6ING = int.parse(score);
  return niv6ING;
}

Future<int> getPuntaje_ING7() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_7') ?? '';
  niv7ING = int.parse(score);
  return niv7ING;
}

Future<int> getPuntaje_ING8() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_8') ?? '';
  niv8ING = int.parse(score);
  return niv8ING;
}

Future<int> getPuntaje_ING9() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_9') ?? '';
  niv9ING = int.parse(score);
  return niv9ING;
}

Future<int> getPuntaje_ING10() async {
  final prefs = await SharedPreferences.getInstance();

  String score = prefs.getString('puntaje_ing_10') ?? '';
  niv10ING = int.parse(score);
  return niv10ING;
}

int scoreTotal_MAT = 0;
int scoreTotal_ING = 0;
int scoreTotal_LEC = 0;
int scoreTotal_SOC = 0;
int scoreTotal_CIU = 0;
int scoreTotal_NAT = 0;

Future<int> getPuntajesTotal_MAT() async {
  final prefs = await SharedPreferences.getInstance();

  //logró funcionar ya que antes estaba como puntajae_mat_1
  //si eliminamos esta forma de obtener por shared preferences, dejandolo separado en
  // una funcon future int, no va a mostrar en tiempo real la sumatoria al banner, debe ser aqui
  String score_m1 = prefs.getString('puntaje_mat_1') ?? '';
  niv1MAT = int.tryParse(score_m1) ?? 0;

  String score_m2 = prefs.getString('puntaje_mat_2') ?? '';
  niv2MAT = int.tryParse(score_m2) ?? 0;

  String score_m3 = prefs.getString('puntaje_mat_3') ?? '';
  niv3MAT = int.tryParse(score_m3) ?? 0;

  String score_m4 = prefs.getString('puntaje_mat_4') ?? '';
  niv4MAT = int.tryParse(score_m4) ?? 0;

  String score_m5 = prefs.getString('puntaje_mat_5') ?? '';
  niv5MAT = int.tryParse(score_m5) ?? 0;

  String score_m6 = prefs.getString('puntaje_mat_6') ?? '';
  niv6MAT = int.tryParse(score_m6) ?? 0;

  String score_m7 = prefs.getString('puntaje_mat_7') ?? '';
  niv7MAT = int.tryParse(score_m7) ?? 0;

  String score_m8 = prefs.getString('puntaje_mat_8') ?? '';
  niv8MAT = int.tryParse(score_m8) ?? 0;

  String score_m9 = prefs.getString('puntaje_mat_9') ?? '';
  niv9MAT = int.tryParse(score_m9) ?? 0;

  String score_m10 = prefs.getString('puntaje_mat_10') ?? '';
  niv10MAT = int.tryParse(score_m10) ?? 0;

  /*
  // no usar el siguiente codigo hasta que los demas niveles guarden el puntaje 
  // o al menos tengan el codigo para guardar los puntajes
    */

  scoreTotal_MAT = niv1MAT +
      niv2MAT +
      niv3MAT +
      niv4MAT +
      niv5MAT +
      niv6MAT +
      niv7MAT +
      niv8MAT +
      niv9MAT +
      niv10MAT;
  return scoreTotal_MAT;
}

Future<int> getPuntajesTotal_ING() async {
  final prefs = await SharedPreferences.getInstance();

  String score_ing1 = prefs.getString('puntaje_ingles_1') ?? '';
  niv1ING = int.tryParse(score_ing1) ?? 0;

  String score_ing2 = prefs.getString('puntaje_ingles_2') ?? '';
  niv2ING = int.tryParse(score_ing2) ?? 0;

  String score_ing3 = prefs.getString('puntaje_ingles_3') ?? '';
  niv3ING = int.tryParse(score_ing3) ?? 0;

  String score_ing4 = prefs.getString('puntaje_ingles_4') ?? '';
  niv4ING = int.tryParse(score_ing4) ?? 0;

  String score_ing5 = prefs.getString('puntaje_ingles_5') ?? '';
  niv5ING = int.tryParse(score_ing5) ?? 0;

  String score_ing6 = prefs.getString('puntaje_ingles_6') ?? '';
  niv6ING = int.tryParse(score_ing6) ?? 0;

  String score_ing7 = prefs.getString('puntaje_ingles_7') ?? '';
  niv7ING = int.tryParse(score_ing7) ?? 0;

  String score_ing8 = prefs.getString('puntaje_ingles_8') ?? '';
  niv8ING = int.tryParse(score_ing8) ?? 0;

  String score_ing9 = prefs.getString('puntaje_ingles_9') ?? '';
  niv9ING = int.tryParse(score_ing9) ?? 0;

  String score_ing10 = prefs.getString('puntaje_ingles_10') ?? '';
  niv10ING = int.tryParse(score_ing10) ?? 0;

  scoreTotal_ING = niv1ING +
      niv2ING +
      niv3ING +
      niv4ING +
      niv5ING +
      niv6ING +
      niv7ING +
      niv8ING +
      niv9ING +
      niv10ING;
  return scoreTotal_ING;
}

Future<int> getPuntajesTotal_LEC() async {
  final prefs = await SharedPreferences.getInstance();

  String score_lec1 = prefs.getString('puntaje_lectura_1') ?? '';
  niv1LEC = int.tryParse(score_lec1) ?? 0;

  String score_lec2 = prefs.getString('puntaje_lectura_2') ?? '';
  niv2LEC = int.tryParse(score_lec2) ?? 0;

  String score_lec3 = prefs.getString('puntaje_lectura_3') ?? '';
  niv3LEC = int.tryParse(score_lec3) ?? 0;

  String score_lec4 = prefs.getString('puntaje_lectura_4') ?? '';
  niv4LEC = int.tryParse(score_lec4) ?? 0;

  String score_lec5 = prefs.getString('puntaje_lectura_5') ?? '';
  niv5LEC = int.tryParse(score_lec5) ?? 0;

  String score_lec6 = prefs.getString('puntaje_lectura_6') ?? '';
  niv6LEC = int.tryParse(score_lec6) ?? 0;

  String score_lec7 = prefs.getString('puntaje_lectura_7') ?? '';
  niv7LEC = int.tryParse(score_lec7) ?? 0;

  String score_lec8 = prefs.getString('puntaje_lectura_8') ?? '';
  niv8LEC = int.tryParse(score_lec8) ?? 0;

  String score_lec9 = prefs.getString('puntaje_lectura_9') ?? '';
  niv9LEC = int.tryParse(score_lec9) ?? 0;

  String score_lec10 = prefs.getString('puntaje_lectura_10') ?? '';
  niv10LEC = int.tryParse(score_lec10) ?? 0;

  scoreTotal_LEC = niv1LEC +
      niv2LEC +
      niv3LEC +
      niv4LEC +
      niv5LEC +
      niv6LEC +
      niv7LEC +
      niv8LEC +
      niv9LEC +
      niv10LEC;
  return scoreTotal_LEC;
}

Future<int> getPuntajesTotal_CIU() async {
  final prefs = await SharedPreferences.getInstance();

  String score_ciu1 = prefs.getString('puntaje_ciudadanas_1') ?? '';
  niv1SOC = int.tryParse(score_ciu1) ?? 0;

  String score_ciu2 = prefs.getString('puntaje_ciudadanas_2') ?? '';
  niv2SOC = int.tryParse(score_ciu2) ?? 0;

  String score_ciu3 = prefs.getString('puntaje_ciudadanas_3') ?? '';
  niv3SOC = int.tryParse(score_ciu3) ?? 0;

  String score_ciu4 = prefs.getString('puntaje_ciudadanas_4') ?? '';
  niv4SOC = int.tryParse(score_ciu4) ?? 0;

  String score_ciu5 = prefs.getString('puntaje_ciudadanas_5') ?? '';
  niv5SOC = int.tryParse(score_ciu5) ?? 0;

  String score_ciu6 = prefs.getString('puntaje_ciudadanas_6') ?? '';
  niv6SOC = int.tryParse(score_ciu6) ?? 0;

  String score_ciu7 = prefs.getString('puntaje_ciudadanas_7') ?? '';
  niv7SOC = int.tryParse(score_ciu7) ?? 0;

  String score_ciu8 = prefs.getString('puntaje_ciudadanas_8') ?? '';
  niv8SOC = int.tryParse(score_ciu8) ?? 0;

  String score_ciu9 = prefs.getString('puntaje_ciudadanas_9') ?? '';
  niv9SOC = int.tryParse(score_ciu9) ?? 0;

  String score_ciu10 = prefs.getString('puntaje_ciudadanas_10') ?? '';
  niv10SOC = int.tryParse(score_ciu10) ?? 0;

  scoreTotal_SOC = niv1SOC +
      niv2SOC +
      niv3SOC +
      niv4SOC +
      niv5SOC +
      niv6SOC +
      niv7SOC +
      niv8SOC +
      niv9SOC +
      niv10SOC;
  return scoreTotal_SOC;
}

Future<int> getPuntajesTotal_NAT() async {
  final prefs = await SharedPreferences.getInstance();

  String score_nat1 = prefs.getString('puntaje_naturales_1') ?? '';
  niv1NAT = int.tryParse(score_nat1) ?? 0;

  String score_nat2 = prefs.getString('puntaje_naturales_2') ?? '';
  niv2NAT = int.tryParse(score_nat2) ?? 0;

  String score_nat3 = prefs.getString('puntaje_naturales_3') ?? '';
  niv3NAT = int.tryParse(score_nat3) ?? 0;

  String score_nat4 = prefs.getString('puntaje_naturales_4') ?? '';
  niv4NAT = int.tryParse(score_nat4) ?? 0;

  String score_nat5 = prefs.getString('puntaje_naturales_5') ?? '';
  niv5NAT = int.tryParse(score_nat5) ?? 0;

  String score_nat6 = prefs.getString('puntaje_naturales_6') ?? '';
  niv6NAT = int.tryParse(score_nat6) ?? 0;

  String score_nat7 = prefs.getString('puntaje_naturales_7') ?? '';
  niv7NAT = int.tryParse(score_nat7) ?? 0;

  String score_nat8 = prefs.getString('puntaje_naturales_8') ?? '';
  niv8NAT = int.tryParse(score_nat8) ?? 0;

  String score_nat9 = prefs.getString('puntaje_naturales_9') ?? '';
  niv9NAT = int.tryParse(score_nat9) ?? 0;

  String score_nat10 = prefs.getString('puntaje_naturales_10') ?? '';
  niv10NAT = int.tryParse(score_nat10) ?? 0;

  scoreTotal_NAT = niv1NAT +
      niv2NAT +
      niv3NAT +
      niv4NAT +
      niv5NAT +
      niv6NAT +
      niv7NAT +
      niv8NAT +
      niv9NAT +
      niv10NAT;
  return scoreTotal_NAT;
}
