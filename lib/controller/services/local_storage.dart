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


  //garantiza que si data user ya se escribió por 1era vez, no se vuelva a escribir
  void setActualUser(name)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('actualUser', name);
  }

  Future<String> getActualUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('actualUser') ?? '';
    return name;
  }

  void setDataUser(name, email, tecnica, avatar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nameUser', name);
    await prefs.setString('emailUser', email);
    await prefs.setString('tecnicaUser', tecnica);
    await prefs.setString('avatarUser', avatar);
  }

  static Future<void> configurePrefs() async {
    //recibe el sharedPreferences como instancias necesarias para leer al momento de abrir la app
    prefs = await SharedPreferences.getInstance();
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
    await preferences.setBool('lec_enabled2', true);
  }

  Future<bool?> setLecBtn3Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled3', true);
  }

  Future<bool?> setLecBtn4Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled4', true);
  }

  Future<bool?> setLecBtn5Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled5', true);
  }

  Future<bool?> setLecBtn6Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled6', true);
  }

  Future<bool?> setLecBtn7Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled7', true);
  }

  Future<bool?> setLecBtn8Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled8', true);
  }

  Future<bool?> setLecBtn9Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled9', true);
  }

  Future<bool?> setLecBtn10Unlock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('lec_enabled10', true);
  }

// PUNTAJES BOTONES PARA AHORRAR LECTURAS A SHARED PREFERENCES

  Future<void> setScoreMat1(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat1', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat2(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat2', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat3(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat3', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat4(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat4', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat5(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat5', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat6(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat6', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat7(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat7', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat8(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat8', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat9(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat9', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> setScoreMat10(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreMat10', score);
    //acutaliza puntajes
    getMatScores();
  }

  Future<void> getMatScores() async {
    prefs = await SharedPreferences.getInstance();
    int mat1 = prefs.getInt('scoreMat1') ?? 0;
    int mat2 = prefs.getInt('scoreMat2') ?? 0;
    int mat3 = prefs.getInt('scoreMat3') ?? 0;
    int mat4 = prefs.getInt('scoreMat4') ?? 0;
    int mat5 = prefs.getInt('scoreMat5') ?? 0;
    int mat6 = prefs.getInt('scoreMat6') ?? 0;
    int mat7 = prefs.getInt('scoreMat7') ?? 0;
    int mat8 = prefs.getInt('scoreMat8') ?? 0;
    int mat9 = prefs.getInt('scoreMat9') ?? 0;
    int mat10 = prefs.getInt('scoreMat10') ?? 0;

    int totalMat =
        mat1 + mat2 + mat3 + mat4 + mat5 + mat6 + mat7 + mat8 + mat9 + mat10;
    prefs.setInt('scoreTotalMat', totalMat);
  }

// score nat

  Future<void> setScoreNat1(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat1', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat2(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat2', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat3(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat3', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat4(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat4', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat5(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat5', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat6(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat6', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat7(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat7', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat8(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat8', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat9(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat9', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> setScoreNat10(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreNat10', score);
    //actualiza puntajes
    getNatScores();
  }

  Future<void> getNatScores() async {
    prefs = await SharedPreferences.getInstance();
    int nat1 = prefs.getInt('scoreNat1') ?? 0;
    int nat2 = prefs.getInt('scoreNat2') ?? 0;
    int nat3 = prefs.getInt('scoreNat3') ?? 0;
    int nat4 = prefs.getInt('scoreNat4') ?? 0;
    int nat5 = prefs.getInt('scoreNat5') ?? 0;
    int nat6 = prefs.getInt('scoreNat6') ?? 0;
    int nat7 = prefs.getInt('scoreNat7') ?? 0;
    int nat8 = prefs.getInt('scoreNat8') ?? 0;
    int nat9 = prefs.getInt('scoreNat9') ?? 0;
    int nat10 = prefs.getInt('scoreNat10') ?? 0;

    int totalNat =
        nat1 + nat2 + nat3 + nat4 + nat5 + nat6 + nat7 + nat8 + nat9 + nat10;
    prefs.setInt('scoreTotalNat', totalNat);
  }

  //score lectura critica

  Future<void> setScoreLec1(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec1', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec2(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec2', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec3(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec3', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec4(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec4', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec5(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec5', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec6(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec6', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec7(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec7', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec8(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec8', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec9(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec9', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> setScoreLec10(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreLec10', score);
    //actualiza puntajes
    getLecScores();
  }

  Future<void> getLecScores() async {
    prefs = await SharedPreferences.getInstance();
    int lec1 = prefs.getInt('scoreLec1') ?? 0;
    int lec2 = prefs.getInt('scoreLec2') ?? 0;
    int lec3 = prefs.getInt('scoreLec3') ?? 0;
    int lec4 = prefs.getInt('scoreLec4') ?? 0;
    int lec5 = prefs.getInt('scoreLec5') ?? 0;
    int lec6 = prefs.getInt('scoreLec6') ?? 0;
    int lec7 = prefs.getInt('scoreLec7') ?? 0;
    int lec8 = prefs.getInt('scoreLec8') ?? 0;
    int lec9 = prefs.getInt('scoreLec9') ?? 0;
    int lec10 = prefs.getInt('scoreLec10') ?? 0;

    int totalLec =
        lec1 + lec2 + lec3 + lec4 + lec5 + lec6 + lec7 + lec8 + lec9 + lec10;
    prefs.setInt('scoreTotalLec', totalLec);
  }

// inglres score

  Future<void> setScoreIng1(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng1', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng2(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng2', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng3(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng3', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng4(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng4', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng5(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng5', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng6(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng6', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng7(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng7', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng8(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng8', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng9(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng9', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> setScoreIng10(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreIng10', score);
    //actualiza puntajes
    getIngScores();
  }

  Future<void> getIngScores() async {
    prefs = await SharedPreferences.getInstance();
    int ing1 = prefs.getInt('scoreIng1') ?? 0;
    int ing2 = prefs.getInt('scoreIng2') ?? 0;
    int ing3 = prefs.getInt('scoreIng3') ?? 0;
    int ing4 = prefs.getInt('scoreIng4') ?? 0;
    int ing5 = prefs.getInt('scoreIng5') ?? 0;
    int ing6 = prefs.getInt('scoreIng6') ?? 0;
    int ing7 = prefs.getInt('scoreIng7') ?? 0;
    int ing8 = prefs.getInt('scoreIng8') ?? 0;
    int ing9 = prefs.getInt('scoreIng9') ?? 0;
    int ing10 = prefs.getInt('scoreIng10') ?? 0;

    int totalIng =
        ing1 + ing2 + ing3 + ing4 + ing5 + ing6 + ing7 + ing8 + ing9 + ing10;
    prefs.setInt('scoreTotalIng', totalIng);
  }

// ciudad scores

  Future<void> setScoreCiu1(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu1', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu2(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu2', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu3(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu3', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu4(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu4', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu5(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu5', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu6(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu6', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu7(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu7', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu8(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu8', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu9(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu9', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> setScoreCiu10(score) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('scoreCiu10', score);
    //actualiza puntajes
    getCiuScores();
  }

  Future<void> getCiuScores() async {
    prefs = await SharedPreferences.getInstance();
    int ciu1 = prefs.getInt('scoreCiu1') ?? 0;
    int ciu2 = prefs.getInt('scoreCiu2') ?? 0;
    int ciu3 = prefs.getInt('scoreCiu3') ?? 0;
    int ciu4 = prefs.getInt('scoreCiu4') ?? 0;
    int ciu5 = prefs.getInt('scoreCiu5') ?? 0;
    int ciu6 = prefs.getInt('scoreCiu6') ?? 0;
    int ciu7 = prefs.getInt('scoreCiu7') ?? 0;
    int ciu8 = prefs.getInt('scoreCiu8') ?? 0;
    int ciu9 = prefs.getInt('scoreCiu9') ?? 0;
    int ciu10 = prefs.getInt('scoreCiu10') ?? 0;

    int totalCiu =
        ciu1 + ciu2 + ciu3 + ciu4 + ciu5 + ciu6 + ciu7 + ciu8 + ciu9 + ciu10;
    prefs.setInt('scoreTotalCiu', totalCiu);
  }
}
