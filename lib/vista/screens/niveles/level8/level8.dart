import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giff_dialog/giff_dialog.dart';

class level8 extends StatefulWidget {
  const level8({super.key});

  @override
  State<level8> createState() => _level8State();
}

SharedPreferences? _prefs;

class _level8State extends State<level8> {
  final selected = BehaviorSubject<int>();
  String preguntaAzar = 'Pregunta!';

  List<String> itemsRoulette = [];
  List<bool> _isSelected = [];

  List<String> temaPregunta = [
    'mat1',
    'mat2',
    'mat3',
    'mat4',
    'mat2',
    'mat3',
    'mat4',
    'mat4'
  ];

  List<String> temaPreguntaMat = [
    'Cónicas',
    'Trigonometria',
    'Derivadas',
    'Integrales',
    'Ecuaciones',
    'mat3',
    'mat4',
    'mat4'
  ];

  List<String> temaPreguntaIng = [
    'Verbo To-Be',
    'Auxiliares',
    'Pasado simple',
    'Futuro continuo',
    'mat2',
    'mat3',
    'mat4',
    'mat4'
  ];

  String _modulo = '';

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });

    if (_modulo == 'Razonamiento Cuantitativo') {
      setState(() {
        temaPregunta = temaPreguntaMat;
      });
    }

    if (_modulo.contains('Inglés')) {
      setState(() {
        temaPregunta = temaPreguntaIng;
      });
    }
  }

  @override
  void initState() {
    print('entrando a inistate');
    _getModuloFromSharedPrefs();
    _isSelected = List.filled(8, false);
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Column(
        children: [
          //flecha atras
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: ShakeWidgetX(
                child: IconButton(
                  icon: Image.asset('assets/flecha_left.png'),
                  iconSize: 3,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 1),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimation,
                                Widget child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.elasticOut);

                              return ScaleTransition(
                                alignment: Alignment.center,
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secAnimattion) {
                              return const world_game();
                            }));
                  },
                ),
              ),
            ),
          ),
          //texto roulette
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    "Roulette",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "¡Sal al tablero!",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.claro,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ]),

//contenedor de ruleta
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.70,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: colors_colpaner.oscuro,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: FortuneWheel(
                    styleStrategy: const UniformStyleStrategy(
                      borderColor: colors_colpaner.oscuro,
                      color: colors_colpaner.base,
                      borderWidth: 4,
                    ),
                    selected: selected.stream,
                    animateFirst: false,
                    items: [
                      for (int i = 0;
                          i < temaPregunta.length;
                          i++) ...<FortuneItem>{
                        FortuneItem(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: i % 2 == 0
                                      ? colors_colpaner.base
                                      : colors_colpaner.claro,
                                ),
                              ),
                              Center(
                                child: Text(
                                  temaPregunta[i],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      },
                    ],
                    onAnimationEnd: () {
                      setState(() {
                        preguntaAzar = temaPregunta[selected.value];
                      });
                      showItemDialog(preguntaAzar);
                    },
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              setState(() {
                //gira la ruleta y cae en una franja a
                selected.add(Fortune.randomInt(0, temaPregunta.length));
              });
            },
            //boton girar
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 130,
              child: const Center(
                child: Text(
                  "Girar",
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'BubblegumSans',
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showItemDialog(String item) {
    String imageUrl = '';
    if (temaPregunta.contains(item)) {}

    switch (item) {
      // ... Comidas ...............................................
      case "Hot Dogs":
        imageUrl =
            'https://www.gifcen.com/wp-content/uploads/2022/04/hot-dog-gif-6.gif';
        break;
      case "Ensaladas":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj69vWCnaXgE69W2Sg-tj_26DwtIvzRu4rQgw7zAIrxpBci3bgJUy9TxCQ413wKYsFzux1hXX8HfmHkn4b4LtRdDonrPBy2rpptcOKH7JWaCn3dO9AEoRNeZkdItEixFZiUap_3iuh6tl4Ft4lyFtf_w4iQSQ6DgEhawRkGckj8dWyim2yOUVHhmg/s1600/avocado-bacon-salad-lunch.gif';
        break;
      case "Pizza":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgD1icZ2qJwbmHHfooJ59pGS_IkmlynJa16bdOHclnsk0zOffCBU3Q8palt-pMwEoz5zh7eIJPQG46VXGm6tM1F8XGPQS0He8KB3K41YncknItMXCZriFIjAPpAiG5v0Fq74yU4Q5-WI-FWXUf2FVETo19CTto7-OGxK_SM-Vf-j1Femr5l7PK-rQ/s320/hellmo-pizza.gif';
        break;

      default:
        // Si no se cumple ninguno de los casos anteriores, establece imageUrl en null o en una imagen de error.
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhIv6Qc9spnhIJoNeei2DPvu3KF7ChsTQmftKJgVEBzO51AsoadUym-Znd0ZP7aJ5Yj_-oKfUJ5a0V2I3MX0lHI6AFG0N-35JYja6zX88x4ghy6AyA-kaqoy-TDBsu5AO0vfozASP3wpxPnYJboAeIyWIqTbWPaFZkR6BuO-byFMUZElfGY44OBTQ';
        break;
    }

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              title: Text(
                '¡$item!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: const Text(
                'Define el concepto con tus palabras, explica como podría servir en la vida real y recibe feedback de los demás.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            colors_colpaner.oscuro,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => world_game()));
                        },
                        child: const Text(
                          'Finalizar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}

/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class level8 extends StatefulWidget {
  const level8({Key? key}) : super(key: key);

  @override
  State<level8> createState() => _level8State();
}

SharedPreferences? _prefs;

class _level8State extends State<level8> {
  String _modulo = '';

  final selected = BehaviorSubject<int>();
  String preguntaAzar = 'Pregunta!';

  List<String> temaPregunta = [];
  List<String> itemsRoulette = [];
  List<bool> _isSelected = [];

  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  @override
  void initState() {
    _getModuloFromSharedPrefs();
    _isSelected = List.filled(8, false);
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });

    // TODO: implement initState
    super.initState();

    if (_modulo.contains('Razonamiento Cuantitativo')) {
      temaPregunta = ['mate Hot Dogs', 'mate Spaguetti', 'mate Sandwich'];
    }

    if (_modulo.contains('Inglés')) {
      temaPregunta = ['ing Karaoke', 'ing Caminata', 'ing Cine'];
    }
  }

  List<int> selectedIndices = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double drawer_width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 19, 64),
      body: Column(children: [
        //flecha atras
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 5, 1),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30, color: Colors.amber),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const world_game()),
                );
              },
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "RulePlan",
              style: TextStyle(
                  fontSize: 70, fontFamily: 'LobsterTwo', color: Colors.white),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _modulo.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'LobsterTwo',
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  //establece el color del borde de la ruleta
                  border: Border.all(color: Colors.black, width: 5),
                  shape: BoxShape.circle,
                ),
                child: FortuneWheel(
                  styleStrategy: const UniformStyleStrategy(
                    borderColor: Colors.yellow,
                    color: Colors.yellow,
                    borderWidth: 4,
                  ),
                  selected: selected.stream,
                  animateFirst: false,
                  items: [
                    for (int i = 0;
                        i < temaPregunta.length;
                        i++) ...<FortuneItem>{
                      FortuneItem(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    i % 2 == 0 ? Colors.orange : Colors.yellow,
                              ),
                            ),
                            Center(
                              child: Text(
                                temaPregunta[i],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                  ],
                  onAnimationEnd: () {
                    setState(() {
                      preguntaAzar = temaPregunta[selected.value];
                    });
                    showItemDialog(preguntaAzar);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elije tus intereses',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'LobsterTwo',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: SizedBox(width: drawer_width * 0.40),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 7,
                  children: [
                    for (int i = 0; i < temaPregunta.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndices.contains(i)) {
                              //agrega la pos del item a la lista
                              selectedIndices.add(i);
                              _prefs?.setString("boton_$i", temaPregunta[i]);
                            } else {
                              if (temaPregunta.length <= 2) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Debes tener al menos 2 items en este plan"),
                                  ),
                                );
                              } else {
                                selectedIndices.remove(i);
                                temaPregunta.remove(temaPregunta[i]);
                                _prefs?.remove("boton_$i");
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndices.contains(i)
                                ? Colors.grey
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${temaPregunta[i]} x',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  //gira la ruleta y cae en una franja a
                  selected.add(Fortune.randomInt(0, temaPregunta.length));
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: 120,
                child: const Center(
                  child: Text(
                    "Girar",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'LobsterTwo',
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void showItemDialog(String item) {
    String imageUrl = '';
    if (temaPregunta.contains(item)) {}

    switch (item) {
      // ... Comidas ...............................................
      case "Hot Dogs":
        imageUrl =
            'https://www.gifcen.com/wp-content/uploads/2022/04/hot-dog-gif-6.gif';
        break;
      case "Ensaladas":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj69vWCnaXgE69W2Sg-tj_26DwtIvzRu4rQgw7zAIrxpBci3bgJUy9TxCQ413wKYsFzux1hXX8HfmHkn4b4LtRdDonrPBy2rpptcOKH7JWaCn3dO9AEoRNeZkdItEixFZiUap_3iuh6tl4Ft4lyFtf_w4iQSQ6DgEhawRkGckj8dWyim2yOUVHhmg/s1600/avocado-bacon-salad-lunch.gif';
        break;
      case "Pizza":
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgD1icZ2qJwbmHHfooJ59pGS_IkmlynJa16bdOHclnsk0zOffCBU3Q8palt-pMwEoz5zh7eIJPQG46VXGm6tM1F8XGPQS0He8KB3K41YncknItMXCZriFIjAPpAiG5v0Fq74yU4Q5-WI-FWXUf2FVETo19CTto7-OGxK_SM-Vf-j1Femr5l7PK-rQ/s320/hellmo-pizza.gif';
        break;

      // ... Bebidas ...............................................
      case "Vino":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEir9e3_A9-56Dg9Z2OnfeQYMX_e57UBLGf3RFSFo4XsbtFRxOTApQDuZ4qZ4ddlSaXvTZ06efch3SJNlZkO3V85lPxozGnbitbJkR-3Bzjt-M5Dc3d5XRE8H5t5PkP4aM2Pvqu1lMMmtV1CjyFxv1pn0ybBTJ2DseDvuyxkxfb8oSr4q1eq9QdWqQ';
        break;
      case "Frappé":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgiHEpCYHKIsv0icL6P8XG6VTaJC9j5wpLJzY5nRhrl8QpP72zjoCTOdSukZwqcZ6nahGSYMLLq54SHyZ-GYBfHkPQEgzF6C1vEA4jtOHCkIsy5ByXpLfqypo5_2_p1YQXbrOhF1dhvqC8NEnE9ggyZbdlhBBEqOKAXbbHcWin31holKi9137F5jA';
        break;
      case "Granizado":
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjj6AXNCRcMcDbOLQb8nly6VU9eTVT_WmkcLR66L8ucd6UL_3dlZ_pKriu81GjThfzByNuTkZq-qYaZfc7x4wr5xc6XroQqLoGV-blq41q9AIDspeAjdvaKsw6dVtlk3zW35p-3rgSark1_pXnfx7KWLrlHi_y0uJq15qL0-kYVg4VGmMWdW3cESA';
        break;

//Juegos de mesa ...............................................
      case 'Dominó':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgexlC7bjii-TYuKyuhCMbzOrKsEWauOltg85D3TNamwkwJ5P6E3jjuu1xfi3Wg21TrwcSL-Lcu4tUKB4R7yzabosLfGW4oCNMcltdqdWEwhAI9EqEVIyFNiMp_B_8FrVrdOJmoRQo2oz9zUMwcP__ZSFLLLyLd7mQiAH2U6Nibrj-VSwq7KRvDzw';
        break;
      case 'Damas':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhR_8aYXr8ze7rL9G0MV9WyOk9eyi8znCi7yXtpSbchvg2jubFfqDUIhkXK2-RgxS0-ahulusbqNjbV3Ol2ZAZE7a7n3yaqDJjTbGW6PxMV681UZmLQZFW7i7A9oZouTVDLBS6n0Df7j5o1lWzpUbTZgzqwxs_sUyASKFHRrihLe5BTWLJcj6kf3A';
        break;
      case 'Ajedrez':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEgi-zKUNmsGJYxIoJXqeuqCQwgBWJyEzL7KcwWZ9iz5-TDdyT_eUbFoyHJwjLLvNVh2507lfnRYrvRZJN9M3V_PT-MSLHWJdMGle1ewxh2yvsDhWzQlEewsJlbvsgY3Z9rgBPWuTcA8WLMHvBFbjh5u-aJ-5gz7f5_Bo5MWMCCK6CwlJXlI_uUOIg';
        break;

//Hobies ...............................................
      case 'Karaoke':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi2PW75NrBm_ydDxchbbvijVyO0upW6Y_G87VoS7qAxiSEgalVXIyipK2_JDUrXqOHD3bode7ZvPne2SeEwXAzT4GAZ6O4vtytI0QXU5F5GaFMrtBk4K-rMvJ2p1qV5-FtQMDfE8uUo6rfk2woqdOTvYhwLcT5QRDQJJ8bvMDzODiRPq-vPzvaPVg/s320/giphy.gif';
        break;
      case 'Caminata':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQpVZz6u0SlFUKQl_MvaN2MyBpAKkPcW027jU_O_q3Fy29S_x0cylvc9V-_M6353hDR8QmDwg6JOGeLz7_Irrh_h4kQqHHOhEyk43dUcWAxVAsE8DnEcy1h_v8JIi0hFQSe72SN8MOKeMy7kpD2lsmGaTeqZ7jKzgOfv-o7z5y7dTkWuOSmTDXGQ/s320/caminata-run.gif';
        break;
      case 'Cine':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4bOardHKQAnd8eyuUsZHZiBM-6dnxdEiLNq8YtaxvpfXNGiaw3ppSaJ1k38FzQ8gRyaGtjEmZwqQABAtTp3LDsOEcRYZM9aW9ixPbRN9e4OF3eIE_ZN5vgvkAg9T5OwEn1TKhKjJQDMSMDFuwEtIeT1P18LVwzR8xe5-ereyO0HB4V4WhL6POow/s320/9b2f740389f231e4d40fd4d16e7ced59.gif';
        break;

//Juegos Outdoor

      case 'Bolos':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgWWXS0I73zUZ6BX5u99FeQpkTU6PCE_r2Sr2AppLeT8WeUv3lL3Jt7EsZ_sr4iO4PWmpug51d14LdSqTxRwW1OmM9lxS0-f7jejIdIrtxJcwnICJhJ4e72aHkTXY6vmjI2m63NgyWp5R8vv_-3gidEPzGu7nTgo_0lv4nUEQAw1YgHCy2oj3xP7w/s320/giphy%20(5).gif';
        break;
      case 'Carritos chocones':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiMWZVHioTW5dYNt2X2pdffGY5Iv6Hsh-rgu4ZU4zXtjuWiJyRx4mroXwEOhHQecAbpmM-Bd5ySg0n5Ksk_iodOMIpdf_I4xq6DdbRLuc09edBAhiHJqFUieDVMgAM45gVs5LAZXDzyL4Ga5I9P2nYGoVAZMzcItIUwjesJcknzPKNqdyYZ9rjB_w/s320/tumblr_mwc39gd6O21rjlxg7o1_500.gif';
        break;
      case 'Montaña Rusa':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgt9K3vX5BAkD-D5Qr7_et4VMtAZQlYy631lTemlKGASoxQ1t-c0R5PNOB8AOob8PV-Z7Iwl6Ppu2FXNxI53scHXjRnv43RUkRMWUGaXOBuVx9w6uTeQYQgabLbpftKzAfxQ-NMgR5MULEeIDd-DLVzojsRycAc1BXeluqkAjEKBdik9_kPnsNZ9A/s320/BestVigorousApisdorsatalaboriosa-size_restricted.gif';
        break;

      //Postres
      case 'Pan':
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEjzqg0McZjPMUNMBDxqh8nDnAMAiqYnyiKAPtEMWsbE4dr9TQc32OaRJDN6R4MwLrqEMdvr9HntRlLDCNwv15aj4HsCFLBdPaKxmXn-YpuImD8adZj-iNO-qkmK0s6H8MhVeWeqvJw0VD1OxQD65-ij2_LRk4kx7Rm3GnuupzwlQYtAI8flvTVBQQ';
        break;

      case 'Natilla':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjE1O7wBzCFpsF0fUUsYbJ5qOmw1RsxexTewXG5VwHkJ_lRTpyYKFahKFr6yNwf4kDbfuSsjKFksBpgz5m3U_vtrcX4b2IdfL6zE0UX39s2b_H9NeZVVuAPN8UBoufKkwYAjs-CMapPcMl05kTcrcXbLLyoHb1ksttDB0xMEl6nCAM6hkh59CFXUg/s320/natillas_caseras_47768_orig.jpg';
        break;
      case 'Arroz con leche':
        imageUrl =
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgIY724EqbEGklBnYouEAjw6ey_iplivtWiIHyROzzwryZlLsZe-K6KGsMuh088YUx9yZ0gWbPPceJF8rR688wZEEyhWvZQ937qOtvNBpF8C2MDHjH7ou95ypbRGWLoHx3QHczw86M1MpK3XRPZwBL7p_oFxkQo2iLjehMNDNbP_vCNlkm8wrVrhg/s1600/e2cb2c9a7b5744edd4131e1b307fa1a6--slow-cooker-desserts-cooker-recipes.jpg';
        break;

      default:
        // Si no se cumple ninguno de los casos anteriores, establece imageUrl en null o en una imagen de error.
        imageUrl =
            'https://blogger.googleusercontent.com/img/a/AVvXsEhIv6Qc9spnhIJoNeei2DPvu3KF7ChsTQmftKJgVEBzO51AsoadUym-Znd0ZP7aJ5Yj_-oKfUJ5a0V2I3MX0lHI6AFG0N-35JYja6zX88x4ghy6AyA-kaqoy-TDBsu5AO0vfozASP3wpxPnYJboAeIyWIqTbWPaFZkR6BuO-byFMUZElfGY44OBTQ';
        break;
    }

    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 1000,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(
                '¡$item!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              description: const Text(
                'Abre el mapa para ver los sitios mas cercanos e interesantes para este plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              buttonCancelText: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkText: const Text(
                'Ver Mapa',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: const Color.fromARGB(255, 188, 19, 64),
              onOkButtonPressed: () async {},
              onCancelButtonPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}

*/