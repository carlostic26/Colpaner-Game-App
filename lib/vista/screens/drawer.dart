import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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

  @override
  void initState() {
    getIsAvatar();
    getGender();
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

  @override
  Widget build(BuildContext context) {
    return _getDrawer(context);
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    _getAvatarFromSharedPrefs();

    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser;

    String tecnicaElegida;

    getIsAvatar();

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        height: drawer_height,
        color: Color.fromRGBO(31, 126, 135, 1),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            children: <Widget>[
              Container(
                //height: 150.0,
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
                      imageUrl: _imageAvatarUrl,
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.center,
                      child: Text(loggedInUser.fullName.toString(),
                          style: const TextStyle(
                              fontFamily: 'BubblegumSans',
                              color: colors_colpaner.claro,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text('Técnica de ${loggedInUser.tecnica}',
                        style: const TextStyle(
                          fontFamily: 'BubblegumSans',
                          color: colors_colpaner.claro,
                        )),
                    Text(loggedInUser.email.toString(),
                        style: const TextStyle(
                          fontFamily: 'BubblegumSans',
                          fontSize: 10,
                          color: colors_colpaner.claro,
                        )),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
              //Entrenamiento
              ListTile(
                  title: Text("Entrenamiento",
                      style: TextStyle(
                          fontFamily: 'BubblegumSans',
                          color: widget.screen.contains('entrenamiento')
                              ? colors_colpaner.claro
                              : colors_colpaner.oscuro,
                          fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.psychology,
                    color: widget.screen.contains('entrenamiento')
                        ? colors_colpaner.claro
                        : colors_colpaner.oscuro,
                  ),
                  onTap: () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                const entrenamientoModulos())),
                      }),
              //Mis Puntajes
              ListTile(
                  title: Text("Mis Puntajes",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: widget.screen.contains('puntajes')
                            ? colors_colpaner.claro
                            : colors_colpaner.oscuro,
                      )),
                  leading: Icon(
                    Icons.sports_score,
                    color: widget.screen.contains('puntajes')
                        ? colors_colpaner.claro
                        : colors_colpaner.oscuro,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const misPuntajes()));
                  }),
              //Avatar
              ListTile(
                title: Text("Ávatar",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: widget.screen.contains('avatar')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    )),
                leading: Icon(
                  Icons.face,
                  color: widget.screen.contains('avatar')
                      ? colors_colpaner.claro
                      : colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () async {
                  //si es primera vez que se ingresa, mstrar al usuario dialogo de genero a leegor

                  if (isAvatar == true) {
                    if (gender == 'male') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const avatarsMale()));
                    }

                    if (gender == 'female') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const avatarsFemale()));
                    }
                  } else {
                    DialogHelper.gender_dialog(context);
                  }
                },
              ),
              //Patrones ICFES
              ListTile(
                title: Text("Patrones ICFES",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: widget.screen.contains('patrones')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    )),
                leading: Icon(
                  Icons.insights,
                  color: widget.screen.contains('patrones')
                      ? colors_colpaner.claro
                      : colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ),
              //Usabilidad
              ListTile(
                title: Text("Usabilidad",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: widget.screen.contains('usabilidad')
                          ? colors_colpaner.claro
                          : colors_colpaner.oscuro,
                    )),
                leading: Icon(
                  Icons.extension,
                  color: widget.screen.contains('usabilidad')
                      ? colors_colpaner.claro
                      : colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),

/*               ListTile(
                title: const Text("",
                    style: TextStyle(
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.settings,
                  color: colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ), */
              const Divider(
                color: colors_colpaner.claro,
              ),
              ListTile(
                title: const Text("Cerrar sesión",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.logout,
                  color: colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {
                  clearSharedPreferences();
                  logout(context);
                },
              ),
            ],
          ),
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
