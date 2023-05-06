import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamicolpaner/controller/services/local_storage.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/vista/screens/pin_screen.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final navigatorkey = GlobalKey<NavigatorState>();

class _RegistrationScreenState extends State<RegistrationScreen> {
  late BuildContext _context;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final fullNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  String? selectedTecnica;
  String? nombre;
  List<String> items_tecnicas = [
    'Sistemas',
    'Contabilidad',
  ];
  List<bool> isSelected = [false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _context = context;
  }

  bool _isFocused = false;
  bool isRadioButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("El nombre no puede estar vació");
          }
          if (!regex.hasMatch(value)) {
            return ("Tu nommbre debe ser de al menos 3 caracteres");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;

          setState(() {
            nombre = value as String;
          });
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          prefixIconColor: colors_colpaner.claro,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nombre Completo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: colors_colpaner.claro,
              width: 1.0,
            ),
          ),
        ));

    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Ingresa tu correo");
          }
          // reg expression for email validation
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return ("Ingresa un correo válido");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          prefixIconColor: colors_colpaner.claro,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: colors_colpaner.claro,
              width: 1.0,
            ),
          ),
        ));

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Se necesita una contraseña");
        }
        if (!regex.hasMatch(value)) {
          return ("Ingresa una contraseña de al menos 6 caracteres");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        prefixIconColor: colors_colpaner.claro,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Contraseña",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: colors_colpaner.claro,
            width: 1.0,
          ),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Opps! Las contraseñas no son iguales";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          prefixIconColor: colors_colpaner.claro,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmar contraseña",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: colors_colpaner.claro,
              width: 1.0,
            ),
          ),
        ));

    final dropdownTecnicas = DropdownButtonHideUnderline(
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Técnica')),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items_tecnicas.length; i++)
                Row(
                  children: [
                    Checkbox(
                      value: isSelected[i],
                      onChanged: (value) {
                        setState(() {
                          for (int j = 0; j < items_tecnicas.length; j++) {
                            if (j == i) {
                              isSelected[j] = value!;
                              if (value) {
                                selectedTecnica = items_tecnicas[j];
                                isRadioButtonSelected = true;
                              }
                            } else {
                              isSelected[j] = false;
                            }
                          }
                        });
                      },

                      //color claro: d1fccf: 209, 252, 207
                      //color base: 1f7e87; 31, 126, 135
                      //color oscuro: 023b40: 2, 59, 64
                      checkColor: colors_colpaner.claro,
                      activeColor: colors_colpaner.base,
                      tristate: false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    Text(items_tecnicas[i]),
                  ],
                ),
            ],
          ),
        ],
      ),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colors_colpaner.oscuro,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text,
              isRadioButtonSelected);
        },
        child: const Text(
          "Registrarse",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: colors_colpaner.claro,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      //color claro: d1fccf: 209, 252, 207
      //color base: 1f7e87; 31, 126, 135
      //color oscuro: 023b40: 2, 59, 64
      backgroundColor: colors_colpaner.base,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colors_colpaner.claro),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 1, 35, 1),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmIk2ZJczE6iW2l6JUOOIULl8cp2LnSZ4NxzjzMH3pyJwsBEev385CaWgNHMFF3_H1pQpvSArkN1P_B5A3M88-iR4J6TvX8WHZo1JtyO6wbmFZLcdH_DSohAc7y4LcU_Pv65CZ-QHdA2_Ua8D_CY1XCQaroCAIthNFeW0o72dBVTU1nINA-fLxJdQ/s320/logo%20COLPANER%20game%20APP%20actualizado.png',
                      fit: BoxFit.contain,
                      height: 150,
                      placeholder: (context, url) => Container(
                        height: 20,
                        width: 20,
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                Container(child: CircularProgressIndicator())),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(height: 45),
                    fullNameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 15),
                    dropdownTecnicas,
                    const SizedBox(height: 15),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                )),
          ),
        )),
      ),
    );
  }

  bool firstLog = false;

  void signUp(
      String eemail, String ppassword, bool isRadioButtonSelected) async {
    if (isRadioButtonSelected) {
      if (_formKey.currentState!.validate()) {
        await _auth
            .createUserWithEmailAndPassword(email: eemail, password: ppassword)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });

        firstLog = true;

        //keep user loged in
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var email = preferences.setString('email', eemail);

        //Se carga a sharedpreferences el buleano que validará el primer ingreso
        LocalStorage.prefs.setBool("firstLog", firstLog);
      }
    } else {
      Fluttertoast.showToast(msg: "Selecciona tu técnica");
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    LocalStorage.prefs.setBool("firstLog", firstLog);

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameEditingController.text;
    userModel.tecnica = selectedTecnica;
    userModel.sumScoreRC = '0';
    userModel.sumScoreDS = '0';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Cuenta GamiColpaner creada con éxito");

    //NavigatorService().navigateTo('/pinScreen');

    gotopinscreen();
  }

  gotopinscreen() {
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(builder: (context) => const pinScreen()),
        (route) => false);
  }
}
