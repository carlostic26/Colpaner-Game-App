import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_female.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_male.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';

class DrawerColpaner extends StatefulWidget {
  final BuildContext context;
  final String screen;

  const DrawerColpaner({Key? key, required this.context, required this.screen})
      : super(key: key);

  @override
  State<DrawerColpaner> createState() => _DrawerColpanerState();
}

class _DrawerColpanerState extends State<DrawerColpaner> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  LocalStorage localStorage = LocalStorage();

  void sendDataUserShp() {
    String name = loggedInUser.fullName.toString();
    String tecnic = loggedInUser.tecnica.toString();
    String avatar = loggedInUser.avatar.toString();
    String email = loggedInUser.email.toString();

    Fluttertoast.showToast(
      msg: " sendDataUserShp: $name , $tecnic", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.CENTER, // location
    );

    //escribo info en shared preferences para ahorrar lecturas a firebase
    localStorage.setDataUser(name, email, tecnic, avatar);
  }

  String _imageAvatarUrl = '';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageAvatarUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEhdORwcTSZjwjYlKKyHakRAdfe2U9tUKiF6QFqoFUDQ1Uci0fjQjCDHZMSorYBSFsB8XN0IkZM7iabV62RQzR6vtQg3cq2a43SNRQp-CX7LGt44G9VjOxukTofGIlmQUv116qwJMcYEzmwlQxznG7B2oJFU0SIRTot_jCDk6TVvoCkoXlSziXWY_ps';
    });
  }

  bool isAvatar = false;

  Future<bool> getIsAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    isAvatar = prefs.getBool('isAvatar') ?? false;
    setState(() {
      this.isAvatar = isAvatar;
    });
    return isAvatar;
  }

  String gender = '';

  Future<String> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    String gender = prefs.getString('gender') ?? 'none';
    setState(() {
      this.gender = gender;
    });
    return gender;
  }

  String name = '';
  String tecnic = '';
  String avatar = '';
  String email = '';

  @override
  void initState() {
    getIsAvatar();
    getGender();
    getUser();
    _getAvatarFromSharedPrefs();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });

    super.initState();
  }

  void getUser() async {
    String actualUser = await localStorage.getActualUser();

    //si contiene usuario, no vuelve a leer user de firebase
    if (actualUser == '') {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());

        setState(() {
          name = loggedInUser.fullName.toString();
          tecnic = loggedInUser.tecnica.toString();
          avatar = loggedInUser.avatar.toString();
          email = loggedInUser.email.toString();

          localStorage.setDataUser(name, email, tecnic, avatar);
          localStorage.setActualUser(name);
        });

        Fluttertoast.showToast(msg: 'datos guardados: $name , $tecnic');
      });
    } else {
      //Fluttertoast.showToast(msg: 'no entró a guardar datos: $actualUser');

      //traigo los valores de shp a las variables locales

      setState(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        name = prefs.getString('nameUser') ?? '';
        email = prefs.getString('emailUser') ?? '';
        tecnic = prefs.getString('tecnicaUser') ?? '';
        avatar = prefs.getString('avatarUser') ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getDrawer(context);
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    _getAvatarFromSharedPrefs();

    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    getIsAvatar();

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        height: drawer_height,
        color: Color.fromRGBO(31, 126, 135, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 5.0),
                        CachedNetworkImage(
                          color: colors_colpaner.oscuro,
                          width: 90.0,
                          height: 90.0,
                          fadeInDuration: Duration.zero,
                          imageUrl: avatar,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              //loggedInUser.fullName.toString(),
                              name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'BubblegumSans',
                                color: colors_colpaner.claro,
                                fontSize: name.length > 24 ? 20 : 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          //'Técnica de ${loggedInUser.tecnica}',
                          'Técnica de $tecnic',

                          style: const TextStyle(
                            fontFamily: 'BubblegumSans',
                            color: colors_colpaner.claro,
                          ),
                        ),
                        Text(
                          //loggedInUser.email.toString(),
                          email,
                          style: const TextStyle(
                            fontFamily: 'BubblegumSans',
                            fontSize: 10,
                            color: colors_colpaner.claro,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Entrenamiento",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('entrenamiento')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.psychology,
                      color: widget.screen.contains('entrenamiento')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () => {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const entrenamientoModulos(),
                        ),
                      ),
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Mis Puntajes",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('puntajes')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      ),
                    ),
                    leading: Icon(
                      Icons.sports_score,
                      color: widget.screen.contains('puntajes')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const misPuntajes(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Mis Resultados",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('resultados')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      ),
                    ),
                    leading: Icon(
                      Icons.fact_check,
                      color: widget.screen.contains('resultados')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const misPuntajes(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Ávatar",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('avatar')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      ),
                    ),
                    leading: Icon(
                      Icons.face,
                      color: widget.screen.contains('avatar')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () async {
                      if (isAvatar == true) {
                        if (gender == 'male') {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const avatarsMale(),
                            ),
                          );
                        } else if (gender == 'female') {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const avatarsFemale(),
                            ),
                          );
                        }
                      } else {
                        DialogHelper.gender_dialog(context);
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Patrones ICFES",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('patrones')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      ),
                    ),
                    leading: Icon(
                      Icons.insights,
                      color: widget.screen.contains('patrones')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      "Usabilidad",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('usabilidad')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      ),
                    ),
                    leading: Icon(
                      Icons.extension,
                      color: widget.screen.contains('usabilidad')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(
              color: colors_colpaner.claro,
            ),
            ListTile(
              title: const Text(
                "Cerrar sesión",
                style: TextStyle(
                  fontFamily: 'BubblegumSans',
                  color: colors_colpaner.oscuro,
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: colors_colpaner.oscuro,
              ),
              onTap: () {
                clearSharedPreferences();
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // función para eliminar todos los registros de Shared Preferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
