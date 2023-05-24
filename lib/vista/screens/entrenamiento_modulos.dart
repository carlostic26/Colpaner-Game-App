import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_female.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_male.dart';
import 'package:gamicolpaner/vista/screens/drawer.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class entrenamientoModulos extends StatefulWidget {
  const entrenamientoModulos({super.key});

  @override
  State<entrenamientoModulos> createState() => _entrenamientoModulosState();
}

class _entrenamientoModulosState extends State<entrenamientoModulos> {
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

  String imageUrlMat =
      'https://blogger.googleusercontent.com/img/a/AVvXsEi65drZlUOAOrTo1nrlpal6HmYjZk-Ju3SFpee8cYOYbWulOYMcuGxU2M-b0o9424zrXnKeqzc-XaiRXhrN9UBJCYBxFhiJxf_c5yHFlj_QVZgkRfCBGKbtkUn-Nsw9xytcwWDgg3KMtFElAINa4Z7UM8qQxNE4kiWutgOS9M2fS5MMAnFPeNjD9j4';
  String imageUrlIng =
      'https://blogger.googleusercontent.com/img/a/AVvXsEh7TLYTExTyHj1uyRWLPST62P-r_mQflNxPYVMHI5B-OH8uYkqKnUDHzLz2PwiBKG5gnyd1sBRmCESj5ped63rSK5bjq0umgls4pbAAWmP3EP3082I-Z1BcbVnQJlwGcXpb9wd3oM7eCPLS4jxabo8KQA_gfSFZSFu5pKYDmyE_j5X2kUjNOiK_z-I';
  String imageUrlLect =
      'https://blogger.googleusercontent.com/img/a/AVvXsEi1jH2x2CgT7WluAub2-EMUziq0YYm25ysPr2Fn0FLxsR2DzdTFin_WqiVAIChrLY5MA_wz5b2YccEW1ZsSCW4QXgYPhwbtRc0grcccbb_xte5p66mbTBWxF7DVfJa1DfuHGRA57moL5cggc0leYWTry3Da9gryZAIa3v79-75bytgspiGSw6Bmu_I';
  String imageUrlNatu =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgVlZMEcIyATGAt8WvewqfTFuZ7iRxukM8Lx5PuL9MmLlKi05scoPqM0uh0sJGNhR125ka5Oz-FsLBSGNd4MfEfJEQ__lRyS09wtx8DsXw7X73tNDB54TMUpzyuc_1JxYWd5HteT7Z7hIlTR61qh8Yix0OTXcw5ltOTTHm9ef-DWLbI8e7ayQVPbQU';
  String imageUrlSoc =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgEe5jwWBVwYp68_ZbLF-sce6LtWa-_2KzpNySHUeU2AesvPYDyEHxdstmma2ab13__HRbyO3PRGOhmSD--gPDsTqLcWbI_FXAk9m2-ng8PAYjBssEpKbrwIrdCf4-pPvUx6KvhBHFnyDjZMRyX5c6vqSwlFJGwp9nEmP03LGIzBV1WhtKGLwTOj78';
  String imageUrlCiud =
      'https://blogger.googleusercontent.com/img/a/AVvXsEhCxRWT-Ydf8ElBK3sgF-eDmyLBES-Couo9xN3Y-R_SpLw7V9Xn7mPMfs6EOpsP9RkVksx6pUF13LGYtvqel0q1USPCV_GpOTuj-WJd_MvZXaw5nq6f7szCus89UC9rbSMpdVoQI69DzOCKCzHSidKzAfExd9W6pThuuAQ3QDBnJSXSAfmyI6X_IUE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Entrenamiento",
          style: TextStyle(
            color: colors_colpaner.claro,
            fontSize: 16.0,
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: colors_colpaner.claro),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          //Lectura critica - Inglés
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //establece en memoria el módulo controlado por el usuario
                        setModulo('Lectura Crítica');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlLect,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Lectura Crítica",
                              style: TextStyle(
                                  fontFamily: 'BubblegumSans',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setModulo('Inglés');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlIng,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Inglés",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'BubblegumSans',
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Razonamiento - Comunicación
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //establece en memoria el módulo controlado por el usuario
                        setModulo('Razonamiento Cuantitativo');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlMat,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Razonamiento Cuantitativo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setModulo('Comunicación Escrita');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlNatu,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Comunicación Escrita",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //competencias ciudadanas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  /*  Expanded(
                    child: InkWell(
                      onTap: () {
                        //establece en memoria el módulo controlado por el usuario
                        setModulo('Sociales');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlSoc,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Sociales",
                              style: TextStyle(
                                  fontFamily: 'BubblegumSans',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), */
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setModulo('Competencias Ciudadanas');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const world_game()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors_colpaner.oscuro,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors_colpaner.oscuro,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrlCiud,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Competencias Ciudadanas",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'BubblegumSans',
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          )
        ],
      ),
      drawer: DrawerColpaner(
        context: context,
        screen: 'entrenamiento',
      ),
    );
  }

/*   //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    _getAvatarFromSharedPrefs();

    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser;

    String tecnicaElegida;

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
                  title: const Text("Entrenamiento",
                      style: TextStyle(
                          fontFamily: 'BubblegumSans',
                          color: colors_colpaner.claro,
                          fontWeight: FontWeight.bold)),
                  leading: const Icon(
                    Icons.psychology,
                    color: colors_colpaner.claro,
                  ),
                  onTap: () => {
                        Navigator.pop(context),
                      }),
              //Mis Puntajes
              ListTile(
                  title: const Text("Mis Puntajes",
                      style: TextStyle(
                        fontFamily: 'BubblegumSans',
                        color: colors_colpaner.oscuro,
                      )),
                  leading: const Icon(
                    Icons.sports_score,
                    color: colors_colpaner.oscuro,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const misPuntajes()));
                  }),
              //Avatar
              ListTile(
                title: const Text("Ávatar",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.face,
                  color: colors_colpaner.oscuro,
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
                title: const Text("Patrones ICFES",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.insights,
                  color: colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ),
              //Usabilidad
              ListTile(
                title: const Text("Usabilidad",
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      color: colors_colpaner.oscuro,
                    )),
                leading: const Icon(
                  Icons.extension,
                  color: colors_colpaner.oscuro,
                ),
                //at press, run the method
                onTap: () {},
              ),
              SizedBox(
                height: drawer_height * 0.20,
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: [
                      ListTile(
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
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
 */
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
