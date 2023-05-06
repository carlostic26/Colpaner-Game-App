import 'package:gamicolpaner/model/question_list_model.dart';
import 'package:gamicolpaner/model/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Este archivo dart contiene todas LA BASE DE DATOS  QUE COMPLEMENTA el modelo MVC
//Contiene codigo SQL que se ejecutara una unica vez almacenando los datos en la cache del dispositivo
//se recomienda iterar el numero del nombre de la base de datos de la linea 13

class SimulacroHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'simulacro_01.db'),
      onCreate: (database, version) async {
        const String sql = '''
        CREATE TABLE preguntasICFES (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          modulo TEXT,
          pregunta TEXT,
          resp_1 TEXT,
          resp_2 TEXT,
          resp_3 TEXT,
          resp_4 TEXT,
          op_1 INTEGER,
          op_2 INTEGER,
          op_3 INTEGER,
          op_4 INTEGER,
          imagen TEXT
        );
      ''';

        await database.execute(sql);

        const String addQuestion = ''
            'INSERT INTO preguntasICFES(modulo, pregunta, resp_1, resp_2, resp_3, resp_4, op_1, op_2, op_3, op_4, imagen ) VALUES '

            // MATEMATICAS: X PREGUNTAS
            '("MAT", "¿Cuanto es 1+1?", "es 100", "es 2", "es 13", "es 20", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 2+1?", "es 100", "es 12", "es 13", "es 3", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 3+1?", "es 100", "es 4", "es 13", "es 2", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 4+1?", "es 5", "es 12", "es 13", "es 2", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("MAT", "¿Cuanto es 5+1?", "es 100", "es 12", "es 13", "es 6", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // LECTURA CRITICA: X PREGUNTAS
            //https://www2.icfes.gov.co/documents/39286/1253831/MR+Lectura+Cri%CC%81tica+Saber+11.%C2%B0+2021.pdf/a2e47376-5a8a-17ca-a082-37d40b1178c2?version=1.0&t=1654133589190
            '("LEC", "¿Qué es lectura crítica?", "Es la habilidad de leer rápida y superficialmente para obtener la información más importante de un texto", "Es la habilidad de comprender el significado literal de un texto sin analizar sus implicaciones más profundas.", "Es la habilidad de evaluar la información presentada en un texto y hacer juicios informados sobre su calidad y relevancia.", "Es la habilidad de memorizar y repetir información textual de manera precisa.", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuántas preguntas de lectura crítica tiene aproximadamente el ICFES Saber 11?", "13", "25", "32", "41", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuál de las siguientes afirmaciones NO es una habilidad asociada con la lectura crítica", "Comprender el sentido global de un texto.", "Identificar la información explícita en un texto.", "Evaluar la calidad de los argumentos presentados en un texto.", "Memorizar datos y detalles del texto.", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuál es el propósito principal de las preguntas de lectura crítica en el ICFES Saber 11?", "Evaluar la comprensión lectora de los estudiantes.", "Medir la capacidad de los estudiantes para recordar información.", "Evaluar la habilidad de los estudiantes para escribir textos persuasivos.", "Evaluar la capacidad de los estudiantes para realizar operaciones matemáticas complejas.", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuanto tiempo debo tomarme en resolver todo el módulo de lectura crítica?", "Entre 10 a 15 minutos", "Entre 15 a 30 minutos", "Entre 30 a 45 minutos", "No importa cuánto tiempo", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // NATURALES: X PREGUNTAS
            '("LEC", "¿Cuanto es 1+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuanto es 2+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuanto es 3+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuanto es 4+1?", "es 1", "es 2", "es 3", "es 4", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("LEC", "¿Cuanto es 5+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // SOCIALES: X PREGUNTAS
            '("SOC", "¿Cuanto es 1+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("SOC", "¿Cuanto es 2+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("SOC", "¿Cuanto es 3+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("SOC", "¿Cuanto es 4+1?", "es 1", "es 2", "es 3", "es 4", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("SOC", "¿Cuanto es 5+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // CIUDADANAS: X PREGUNTAS
            '("NAT", "¿Cuanto es 1+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("NAT", "¿Cuanto es 2+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("NAT", "¿Cuanto es 3+1?", "es 1", "es 2", "es 3", "es 4", 0,1,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("NAT", "¿Cuanto es 4+1?", "es 1", "es 2", "es 3", "es 4", 1,0,0,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("NAT", "¿Cuanto es 5+1?", "es 1", "es 2", "es 3", "es 4", 0,0,0,1, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'

            // INGLES: X PREGUNAS
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuando usar el verbo to-be?", "En el cine", "Nunca", "Siempre", "No lo sé", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg"),'
            '("ING", "¿Cuanto es 1+1?", "s 100", "es 12", "es 13", "es 2", 0,0,1,0, "https://concepto.de/wp-content/uploads/2021/06/suma-e1624939411354.jpg")';

        await database.execute(addQuestion);

        /*Se recomienda eliminar la version anterior  de la base de datos mientras se testea el software
        deleteDatabase("gamilibre12.db");*/
      },
      version: 1,
    );
  }

  Future<List<question_model>> queryMAT() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db
        .query('preguntasICFES', where: 'modulo like ?', whereArgs: ['%MAT%']);

    //imprime bien en formato lista visible el queryResult
    print(
        '----------------------\n\n\ndbexam.dart: IMPRIMIENDO QUERYRESULT MAT dbexam.dart:\n $queryResult');

    //al ser un map, no imprime de forma visible sino:  [Instance of 'question_model', Instance of 'question_model', Instance of 'question_model', Instance of 'question_model', Instance of 'question_model']
    //print(List<question_model>  list = queryResult.map((e) => question_model.fromMap(e)).toList();
    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }

  Future<List<question_model>> queryING() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM preguntasICFES WHERE modulo like ?', ['%ING%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    print(
        '----------------------\n\n\ndbexam.dart: IMPRIMIENDO QUERYRESULT ING:\n $queryResult');

    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }

  Future<List<question_model>> queryLEC() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM preguntasICFES WHERE modulo like ?', ['%LEC%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    print(
        '----------------------\n\n\ndbexam.dart: IMPRIMIENDO QUERYRESULT LEC:\n $queryResult');

    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }

  Future<List<question_model>> queryNAT() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM preguntasICFES WHERE modulo like ?', ['%NAT%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    print(
        '----------------------\n\n\ndbexam.dart: IMPRIMIENDO QUERYRESULT NAT:\n $queryResult');

    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }

  Future<List<question_model>> querySOC() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM preguntasICFES WHERE modulo like ?', ['%SOC%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }
    print(
        '----------------------\n\n\ndbexam.dart: IMPRIMIENDO QUERYRESULT SOC:\n $queryResult');

    return queryResult.map((e) => question_model.fromMap(e)).toList();
  }
}
