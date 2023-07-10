import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/drawer.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class avatarsMale extends StatefulWidget {
  const avatarsMale({super.key});

  @override
  State<avatarsMale> createState() => _avatarsMaleState();
}

class _avatarsMaleState extends State<avatarsMale> {
  bool _pressed = false;
  int _selectedIndex = -1;
  List<bool> _pressedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String _modulo = '';

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  String _imageUrl = '';

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ??
          'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw';
    });
  }

  bool primerAcceso = false;

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  Future<bool> _getPrimerAccesoPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool primerAcceso = prefs.getBool('primerAcceso') ?? false;
    setState(() {
      this.primerAcceso = primerAcceso;
    });
    return primerAcceso;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAvatarFromSharedPrefs();
    //setAvatar(userId, avatarUrl)
  }

  @override
  void initState() {
    // TODO: implement initState
    _getModuloFromSharedPrefs();
    _getPrimerAccesoPrefs();
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
    _getAvatarFromSharedPrefs();
    final double totalWidth = MediaQuery.of(context).size.width;
    final double cellWidth = (totalWidth - 16) / 3;
    final double cellHeight = 40 / 3 * cellWidth;

    const borderColorPressed = colors_colpaner.claro;
    const borderColorNormal = colors_colpaner.oscuro;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Elige tu ávatar",
          style: TextStyle(
            fontSize: 16.0,
            /*fontWeight: FontWeight.bold*/
            fontFamily: 'BubblegumSans',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: colors_colpaner.base,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ShakeWidgetY(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/banner_user.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 28, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  loggedInUser.fullName.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'BubblegumSans',
                                      fontSize: 14),
                                ),
                                Text(
                                  loggedInUser.tecnica.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'BubblegumSans',
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //img avatar
                          Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.18,
                              height:
                                  MediaQuery.of(context).size.height * 0.068,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  width: cellWidth,
                                  height: cellHeight,
                                  child: CachedNetworkImage(
                                    imageUrl: _imageUrl,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),

                          //puntaje total
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Puntaje total",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'BubblegumSans',
                                        fontSize: 13),
                                  ),
                                  FutureBuilder<int>(
                                    future: //puntaje shared preferences
                                        _modulo == 'Razonamiento Cuantitativo'
                                            ? getPuntajesTotal_MAT()
                                            : _modulo == 'Inglés'
                                                ? getPuntajesTotal_ING()
                                                : getPuntajesTotal_MAT(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'BubblegumSans',
                                            fontSize: 13,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox(
                                            height: 10,
                                            width: 10,
                                            child:
                                                CircularProgressIndicator()); // O cualquier otro indicador de carga
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /* //nombre y tecnica
                    Positioned(
                      left: totalWidth * 0.12,
                      top: MediaQuery.of(context).size.height * 0.045,
                      child: 
                    ),
                    //image avatar
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.032,
                      left: MediaQuery.of(context).size.width * 0.40,
                      child: 
                    ),
                    //puntaje total
                    Positioned(
                      right: totalWidth * 0.15,
                      top: 35,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 1, 1),
                        child: 
                      ),
                    ), */
                  ],
                ),
              ),
              Column(children: [
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: _gridViewAvatars(borderColorPressed,
                            borderColorNormal, cellWidth, cellHeight)),
                  ),
                ),
              ]),
              Expanded(
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        //asigno avatar a firebase
                        Fluttertoast.showToast(
                          msg:
                              "setAvatarFirebase(${loggedInUser.uid.toString()};", // message
                          toastLength: Toast.LENGTH_LONG, // length
                          gravity: ToastGravity.CENTER, // location
                        );

                        setAvatarFirebase(loggedInUser.uid, _imageUrl);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const entrenamientoModulos(),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors_colpaner.oscuro,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerColpaner(context: context, screen: 'avatar'),
    );
  }

  setAvatarFirebase(String? userId, String avatarUrl) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //update avatar in sharedpreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarUser', avatarUrl);

    print('await prefs.setString($avatarUrl);');

    await firebaseFirestore
        .collection("users")
        .doc(userId)
        .update({"avatar": avatarUrl});
    Fluttertoast.showToast(
      msg: "Avatar guardado en firebase", // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.CENTER, // location
    );
  }

  Widget _gridViewAvatars(
      borderColorPressed, borderColorNormal, cellWidth, cellHeight) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
      children: [
        _buildAvatarButton(
          index: 0,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOjqtlJ0B6Wr2FircsiqSEoW_zktifuRI1qSbdInXMrBKnNfEc8A-3lkLYyS7Wk6hE6-l2u8vKG2arhhgU-tnnCHWpSQ2BQLRjvFvakSSx8NO7tss0ZP-4_rXzwZssbcN8PJIZuyw71pJnLcTlmQFCPX40gMFEP1ahKsQadpOVLpAN0UXLWzjLC1w/w200-h194/a1.PNG',
        ),
        _buildAvatarButton(
          index: 1,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDq9UyZb1p4kriNXrN-QfrZP_Lj80fPV7EP1Lf6RW7EZhwu1n0y6sCz7Wkzg_SoP41NvuX2GH2xapMlZNbRZ7cDDkVk_sSsLLeyQ1tweAleO_zbZPU0fPAsffIVx7jUQqqQVcbrYuf_KhO_9stdh77W0g4hYxn9eXzyOrv6-MWnaEdEjX7YSjeN20/w200-h197/a2.PNG',
        ),
        _buildAvatarButton(
          index: 2,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyIcDtwypK8LqEi1Ad-BSS1uxz4gbcp7M3FlsCPbwlyCLtMQgs4FaMQE2qWDofnZ1HrtxHNobKQQ-0c4854vHAY3X64Q9FtD1Lf468rLB3kvJQdBPcTEkhW6ZWiUrnrSWrIv0rQd5zQCj0KzDqsy-9GxQkANeZwEuIpWyMMlgkV-64aHBKo0Wu7J0/w200-h173/a3.PNG',
        ),
        _buildAvatarButton(
          index: 3,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiUDqeQ8AiJoaU77yHFHof-0L8cu37nKs7DkVrNPzI5Xc2qVlo9eYCwGZXCzZ1WMDKtSQFPAaLpRWiVLBOQINYwPCo3fP_PeNtJRs95NHjz87vTZnOT-uro400RPcEXmcQc5-xCJ40_38IOJ6aYoLgYebCGBlPF37K9ju3HVkiXjpXuCO5c0uRs9lo/w200-h184/a4.PNG',
        ),
        _buildAvatarButton(
          index: 4,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiU3b9bRIHvWyoleUQExaJnFxZGFR_nfek8rv-_idzIdGgfZzBF2ZcqyM1cxCL07rU817M830dmmYZNXTA2p72_JbVJmgKyVcIl5BZm-H4MBZoLLzYLqSXbLG6i-XoyJLbnRSKdd20ygnYS6A8N5WWaSvcdBeIpeaBKR5DFvzCOQn8CCezj75Io9zY/w200-h188/a5.PNG',
        ),
        _buildAvatarButton(
          index: 5,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgsaXNdoH1wK8jCEKE73LtHhrr9rqR1NoJV2KnIDl7aIkFaCaU-VAlbRqasIO36pRKFuTYSHwE86auXd6ebJY0m_Jfowh3jZauu5tCLOr5MSo6x33vmr82VI1HswiVszMlEzyp8qA4X_xBPfiBwVoVNAK-b61XatB91TsRNGPJ2lfVNUMXnE7wHlSw/w200-h183/a6.PNG',
        ),
        _buildAvatarButton(
          index: 6,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEinRweYojRSLAMDhJ7dv0i_1cSPYldFVOnhPnf4lBqqL-sn3irpKcbawMpXB-fDtqDDBBGqds6BX9dCp3v1yo0WNRfdx3arTUdVt-10l-RzFuPYzTV0ge8T_pbXXjnscqH9qvYYtgVeAZjpJwPLen7kqjeqRVn9Aj4WGq6QPC797gNElWGOjpF7mog/w200-h175/a7.PNG',
        ),
        _buildAvatarButton(
          index: 7,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuP2sCiPlv5QCRCWn5n0EMtdpTN-pzuxPsmqhBm33uco__26Y33E5Yc3hAlpW7KFTgLQBIpLY72rss7DP1SyuvNw69se_Sw5UuB6FES7EfEmAh1fWnp0XTHOFrccOf0S367aEi_dJiYd0TGXFXGR-9SYnxiNGGJLb8W4j4x9vMMNHCrg1LxpYiTXA/w193-h200/a8.PNG',
        ),
        _buildAvatarButton(
          index: 8,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpJ3pxZ-MBVQF_OqSfGTTL3nOKG3HvrEsnbLHNJk_aWW53FseQ3gMhxfb5xd_0AfB4ZXJUTxfbBr1eXuqWbVU6aBag64-pXBSoZtv0nCycsCyLv6BqOcphSX2xfQpRSnaCOHDgUffR4EuIAGDqnVwDp6knydmsSJclUG7Q-p8oBT1mt2iZnVZPlOo/w200-h176/a9.PNG',
        ),
        _buildAvatarButton(
          index: 9,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKOZmTI7fVhyfhZRsZt4IGCY-f3hNo70tYoeEiLh8pEkrLpY4HTk5zv4d9L54VBw3XWyPBjWU5NhD4sESi2auZLorgGshr-DsOxf6kUVSla6RLihdqCEf_ki2Pj3p19wHUU0Z6XIdcKRBaQoTyydgeOantNfeYQIO-fI4l7jFlpvIFvXzwtDmdTFw/w200-h189/a10.PNG',
        ),
        _buildAvatarButton(
          index: 10,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEivae6Qa9ZQ9FuL-fPJeCIPsSyzQ2Tkxbpa4cfClHYGQVHfSGGqsUHf5Bl7Fq6s2xZpYU5Lp7DX_yAg9quOAcK7Op0X2GPaiP8MMb-HxWfhmtSBsARCda5OUl2qZsjjqeYHj1Q3mezdhpNlJOMdCGF0aGrsJRogT2jJc-HSxMsXRbURyHXESGGn0RQ/w200-h180/a11.PNG',
        ),
        _buildAvatarButton(
          index: 11,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEibgyNVef3pMWSbrV1t9XzN8irYLlX1jQ4AUsxvFupQezI-InwgvKas0GmgxG-fDoJmBBmkdc_La2FTwhFaRbYHKSHxJZKEliiZu8tTpL8HhyGds8AtpaUIdHvDEO4M_mt8cyrywJp7MGiH8qIOBcEgUaGlBvxscXd2A0Qwh1OZCKBQ6eSdbin1PwI/w200-h184/a12.PNG',
        ),
        _buildAvatarButton(
          index: 12,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjstDuUAGlFImGwO7ry2o9KuLyNn9RleLtoSZzI5oZj9by5zupufwfaaTT2JpymTddnvNO_pTipptpKXY6PUSoYRWq2PAWmrelc-DjgtkHPixuO4RbNANo8GNzZ8b8pjZdGVrYdMMTJEzY0BWSTUQ2XWqShCaKy4sNHwaTjXurQpvPycPl8lphJls/w200-h194/a13.PNG',
        ),
        _buildAvatarButton(
          index: 13,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgJoEf5FVZmF93CAJK6s3IF7gOjpKo8O8ByTjmDW08Eq1aBNOAR3_tAO7EW4HSSOHqmNlIGsAZP6pfH_xTRbtlb1_mnxUYBfCZnCfVuyVpsIM0Qm4zudHoavXovWx57pjDgQx8Ifwm5wFEGs7AYlnCJLEXE0BrVNKd1ZjhVdoIaWYPi55PFvqzrSmc/w196-h200/a14.PNG',
        ),
        _buildAvatarButton(
          index: 14,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFcEGdckscnEueJkXni-pdqYJ0Jg_tT2BwmpSkWTy4y6BOsE6ctJIpRiPWaPsV9bZgAsOCbzZQQwRjtwcDobAEev3xRM2ttUtHTpXny5lIa4A7-LTSphqiZkRBTFrMfI6y4XV6WGpIdqR9C9MUwpTf9bZF-c4qx-gyCX3PaxYUIx93oWqybyNOzIc/w200-h191/a15.PNG',
        ),
        _buildAvatarButton(
          index: 15,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEii7EwxwmRNxW4X1cW6ts0gx_Y-Wj2j-5SkuCBZpcBGWCIAW3-2ShziH5Q2lnH_t7ZIQOMGE8kLkc9YagldqSpePyUA_q-JUi69mbSh6J227KYJhS6lulPCBip0xVV_qCRE4HXs9oBPmoBrJaNaG4wfYDLFJaIYHOeOir49c4XYs4696wbc3p3Htt0/w200-h194/a16.PNG',
        ),
        _buildAvatarButton(
          index: 16,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiK13i2IXA5xDPbj1jTJTcjDXqfBMdVlIiArnRiJmRC1_0q0Qkd8mnvDQKAwbBcR9OmKEfWUNaGfHVrEjSv8QbFb8FB8LBiSPLg0SqIBQ69dzoX-wOcSm-vAmNIXRIda3KIGJS5Y2Q8MjgMpbLa_gtaqT7s--wjQnkEJwV2VOIuiqwLpha76bLSbzo/w200-h182/a17.PNG',
        ),
        _buildAvatarButton(
          index: 17,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhKSVqM1exFsEbcTsLYQcoPNdGZGcJWYEEj8n4NHMUGsitr9xcx37-wAXvRs61ytfvWPfz7CLpSGYJnFWEEurxyHNQnt5KPYd9OGKKlORYwEhOsu4Izsi-Zx4xFXFPfl2KT5ucnK38UJueHImIqC0PdMoHp9QY7ACMC3wZhbjhX7G2GU7OVj5u6wFI/w189-h200/a18.PNG',
        ),
        _buildAvatarButton(
          index: 18,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj91SFh5PVLEMNbpcOOvbRy30EE1U65BopoyMQahXTciee1PDuLZEuhw-8iVvlXOXCLNe06vlLz7zuj1SVUI3WUOLqzBiU6h0Tih6Pi20S4HMBLt7Ge613_-aiSthnegP47P0VYBYFk3bs2hWtsRUSjMOb5mp-S64W0yiVbqXnhBywYpT5qRwUSN0c/w200-h175/a19.PNG',
        ),
        _buildAvatarButton(
          index: 19,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiveABYTJ8VC2t5o_TdFmQtzYIaQ-KnIKRBoMmMHiLDqU4Lw99k3FyJnCoFVAq-wM0M81sej6a9VdBHi7bJOlSTTp-Vtpu-8RKa5xjpmxLSK3kLhrRNp-BE3hkSWQCqyfvlvh3q3D2jpFtOnXPhvitLOk3nwngu6Rx12WtV8lgKCp3rjfpWhy9zHLg/w199-h200/a20.PNG',
        ),
        _buildAvatarButton(
          index: 20,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhXNKwXomYWT1Mmz84Qu7GxQCs-CBSLc6YQjZuV6t6jLJTmObeeb2krTzqLSUnfAISwaETtq_VGtg3GXOw4LAmcr07PyxpTvvFIW8jMYnM7pU9hHRAD-0mVRRdgiXDkHsrFs-g-kMQGQ92fdwtM2LA-RlYBDkHO4BGalLXuUlbOCV8Ap9jDMcyDFaw/w197-h200/a21.PNG',
        ),
        _buildAvatarButton(
          index: 21,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgxomsptqxripXbR2R50Sy_01QyPbMvO5GwSSlRP3q2jS7lGIHw1J-VuWYE5CTpjmxWWjpY98dq8xQDGd8z5Zo2vNjGuJCLmml1usw7-l1G_SF0rFz69e-2zARS7RWRAZuPuv_eqDed3G6FFZfyD3O5ObFx-3jGjJLGIAhzFnlefFBA4Hqkolt5kYc/w200-h189/a22.PNG',
        ),
        _buildAvatarButton(
          index: 22,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTwvZS4mYKnYyGzRJv0H32F5YJmspIcVaeWMoGiGYW_g9UJydxz-ITjpyJxZT67yWl76Q-ujLqeRJOPUCvLHrrH44inhDWidHxzHaJ11h_q6P9tOnJRJfVvEprbL2MtqcbhRcM8-KZbArAaSahcOAJZNx7KTClQ5ULZFe8ADdJ3sfiC_0uEzxOh7g/w200-h188/a23.PNG',
        ),
        _buildAvatarButton(
          index: 23,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgYdCvPdk5IVdyh1h2gjZFXkBW28q7LBQNQBWfhNpomwMBeTxK_RFJTreTQHY634sv5c9Hn_094UH1fFXazz2EqD4ofFeAROQLPSDA3XeO3qS81HzRXbhXnljCBN321iRW4POz8BBjSh6h_abo0yxRH-3uqleD3HH4VciTbf3JOgKlxdIwic5upUYc/w189-h200/a24.PNG',
        ),
        _buildAvatarButton(
          index: 24,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFOGoXMaSvcv_o-vyaJjj8z7sY_DmsJQoKkZof1tIMaavxx-yoZ2prohlRb8BzTB-LQg2XJBl5xwEZmzTrCOO2GCHCzyIwXpRgnd88pE6PqtEa3tqjKtwZysaSVfmDrIhcqaAtKXM2BBJWL6CtBCDYVIEGNkhlE4Rhf8adFRBnK341TWvKpjQtHUQ/w200-h177/a25.PNG',
        ),
        _buildAvatarButton(
          index: 25,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhxxSBln1IMxbV8b-P1s9RyyAUdJzQyl_Rx3yPy4rw1okBobkb_hQ8DzeCR2bYr4KzohLRAxqE9nbHcLIWrAYvhaqIFaiBPyfYDSbj1iBdpo8rXAxJaub1zIM_kGUaxuCf3DopQtN7S9uD-gacNNwmNx38VofUsE9P4PPkhOuivU7hwthZB5nEfyWs/w200-h196/a26.PNG',
        ),
        _buildAvatarButton(
          index: 26,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEheDwBXo6l1vodxWL5DP5hFFfjaWvQDsmbyQdxT4kM_bhSPXLrj0hMXGkKDCD1AsQgj0JDMLJ8Sd28H91PvgrrC0SyfDPOw3XMLiQBWCwd7BjBOLr5xMutYbl5xMkQp9ZgsybGOGr_Y3I-MFQ06G4-64RTJwLUlhhhOMe7J5RPTnHo4OXuKZbYvY5M/w200-h166/a29.PNG',
        ),
        _buildAvatarButton(
          index: 27,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZEgw7OjERAlc1AT2PrtI4CKTgDoD1lxtlF0tHkeVlp-StbvVwZ2vj0kU1jAWF9h_4yt7ZunRt36YtGlQRd5XWytZil_TLnaLTEZcrqMaBaAYmSkbEPd_jQbXz6p-3tAMO7ca5x9KiejfpBsuUQJH5hn0iYf1BTTOVSZhRS4vKxTF6-NcYSps7QNE/w200-h184/a28.PNG',
        ),
        _buildAvatarButton(
          index: 28,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgaSA9pLViBwbcazLySBokvuHaNWwk0xzUwsm42XrR12nIDL1h0Mm8--FLG7u1DhdNMb1J5OC-Z5XN8oRPorw4du3QOxbOYgZnei-VMIL5Huasf8gjnK-BcYo7ZeXz0gGxjfHBFMfBqFzFvsLnBoeHBiVKhAQ0CJNnXst1hhfIqmd1NdLr5VrBCqiI/w200-h159/a30.PNG',
        ),
        _buildAvatarButton(
          index: 29,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjN-TSnxF2TDYgh4jl4vzzf0SnZZ9itiXY4bg7H0meJ4neqjNoNQNqZVo0R_PDXDcr9Al8OJ-0Km5_Rt6AXnUMhh8pqjX61qQB2lQMZxcELjYwCOALxylMzVxggfxltpc29_EjOSYWORDKtln1EMKAfWxtLmfvhQey6rrhvW3PC__Ge4NkV4bXDmCM/w195-h200/a31.PNG',
        ),
        _buildAvatarButton(
          index: 30,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg56svWiRo-m-XDkJ8_jGnfLZxLIHKn8Bucoj-ZIEmPwxNcy6nboDVt53UYrFmm6XpqMYwilpxiB_DIIu9tySOOHtRXsCyvY8usadHxTC5FIDsY3ifJMU4FpmT6DIZp-nYuReagPwMw_xiy8Hoh1JzwZlXa19Mv7InrLVL5fzVkVePK59LG7WhR184/w196-h200/a32.PNG',
        ),
        _buildAvatarButton(
          index: 31,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj0AENvdUGR9XVEOXwT6up3nwdmpKpnx98FTl55bxJxZDnAADqbKSRhQ8vxGJRT3EG7NsXEST2_z3sFXo0oXU4mTlZnV9NMAOFf0a7k8HUB-LcXkP808WwT6SB78e6RhTYhdnkA0usza_2zOpegXvugkx1_Ty9PJmNAtVvDNdlp3TyvTn5SuYl_vq8/w191-h200/a33.PNG',
        ),
        _buildAvatarButton(
          index: 32,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiuWjBWqxdpd0ehwfrcR7N91c8nvd4aySxL3y6WB2gxYOeFwE3JBDwR7pRQGGWbKmXJq8obDRUR1zqQWPd6N2Evp44VfYSkEuplxi88KslDQrjjY5Jao_p62Dk9DE9EMnKDX7pdmTkDehZZHeLbkXUX4Kbv8vobzTgJu80DSVTUaOPF_VW61fOg7Ns/w193-h200/a34.PNG',
        ),
        _buildAvatarButton(
          index: 33,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjKC8AxUVHEq2CmHn5ShvKn1-oMpiwd3ukInOQWTwzipiQR30-jbQi_TCwl-h8PE0T-XPnG-w8eQcgdl5D4cUqzvyrgPMLgJI9k7JPcytGXR1thGGhOkepWdfcT4g8-s_W-3N_6QyeMT6zkkaHPAUFNumIhewx5w00CoGCW9F9DVDcaYKipJaSFKCA/w200-h183/a35.PNG',
        ),
        _buildAvatarButton(
          index: 34,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyHovuJ8FHxxPmDka8FOyvI2FyZ9pU-LUoGNLBsoOO0650IU6E5NpHZBGvwRtvsv17zpruWebFmJHakXRKqQXSloeVYW8ICCqPo9SelkPdyI4bX4aGpp2I4tpUz0tuZLZgP_teD5dGPN-32kFpbsTJQVpacK0OrUOKsPkZJm9BC8PqfX-3tksCmFo/w200-h199/a36.PNG',
        ),
        _buildAvatarButton(
          index: 35,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgfI27-GUkFzkuaWsJ3rZyU33fdT5h62VyDiZRTBTe8w6ny6FrNHWbV131Q6VAHJnwApGdU_lELAhLz08RFMK3jQuC5bCPTErEUbZO4QrXdCSKpc_pGIA0NuXbLl7-p2YAFfRrcM2zFtWiq8KeydfnQnhHVlGUzXFEHtxrybjKJ2wGrlASECj_uL3U/w200-h193/a37.PNG',
        ),
        _buildAvatarButton(
          index: 36,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjX5D5VSEQ4WTqbBlf_Bk8ER7iNqq8iYrMZPIui-Jf03ibpq81W3orKdMpP8b9rqGUfeKdZEcVOMSt1kWupggb83fqSr5g-yugZrFlsEjtVyAweJB8E7AmYP5OUg_HtOEqbsZ7wyc3PNxMFiLGmbxRI9NZ_kB1MBZmv7FH5lbySKpKa8klFC0gRVzE/w200-h186/a38.PNG',
        ),
        _buildAvatarButton(
          index: 37,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjtuFAQp0DAN4tw0R2PVV0d_bzz8egfCWBRGHqSm8YSJqUoq1gtqYvhaypKWOA7CS1skC3apCen4t6sxMcyor-gZVApOYPkRbcRckbZ_O8n5EjFKItLaKz57-ad12xz023rd0uyAG0pyi7f7Y9pOWvh3qXyDTqAHaziw591RmtZNxiVpvry_v4JRvw/w200-h185/a39.PNG',
        ),
        _buildAvatarButton(
          index: 38,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijNAjlNPZtrQCCSKj8BsOsU9507KWp2tNDcdrrY935Gqi5hdtiAblfTZ2VPK53DN0ZDGsTqAuV0gKrWMFaGpY4_bAkuWtYbcRC5hspj9Zd8ECi6xHI249HETAHxqq1ttEwpB1RzJloOoDHpX-YdeRLgZROKOEd2m9JWxblKm9OnMWUYK_T5qCoFD0/w200-h189/a40.PNG',
        ),
        _buildAvatarButton(
          index: 39,
          borderColorPressed: borderColorPressed,
          borderColorNormal: borderColorNormal,
          cellWidth: cellWidth,
          cellHeight: cellHeight,
          imageUrl:
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEheDwBXo6l1vodxWL5DP5hFFfjaWvQDsmbyQdxT4kM_bhSPXLrj0hMXGkKDCD1AsQgj0JDMLJ8Sd28H91PvgrrC0SyfDPOw3XMLiQBWCwd7BjBOLr5xMutYbl5xMkQp9ZgsybGOGr_Y3I-MFQ06G4-64RTJwLUlhhhOMe7J5RPTnHo4OXuKZbYvY5M/w200-h166/a29.PNG',
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _buildAvatarButton({
    required int index,
    required Color borderColorPressed,
    required Color borderColorNormal,
    required double cellWidth,
    required double cellHeight,
    required String imageUrl,
  }) {
    return InkResponse(
      onTap: () async {
        // Si se toca el mismo botón, desmarcarlo
        if (index == _selectedIndex) {
          _selectedIndex = -1;
        } else {
          _selectedIndex = index;
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('imageUrl', imageUrl);

        print('Avatar $index pressed');
        setState(() {
          _getAvatarFromSharedPrefs();

          if (primerAcceso == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const avatarsMale()));

            primerAcceso = false;
            prefs.setBool('primerAcceso', primerAcceso);
          }
        });
      },
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.green.withOpacity(0.6),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index
                ? borderColorPressed
                : borderColorNormal,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: cellWidth,
            height: cellHeight,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
