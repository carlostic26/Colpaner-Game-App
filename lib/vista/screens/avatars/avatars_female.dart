import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/puntajes_shp.dart';
import 'package:gamicolpaner/model/user_model.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/auth/login_screen.dart';
import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:gamicolpaner/vista/screens/mis_puntajes.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class avatarsFemale extends StatefulWidget {
  const avatarsFemale({super.key});

  @override
  State<avatarsFemale> createState() => _avatarsFemaleState();
}

class _avatarsFemaleState extends State<avatarsFemale> {
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
  String _imageUrl = '';

  //recibe el modulo guardado anteriormente en sharedPreferences
  void _getModuloFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _modulo = prefs.getString('modulo') ?? '';
    });
  }

  //recibe el avatar imageUrl guardado anteriormente en sharedPreferences
  void _getAvatarFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _getAvatarFromSharedPrefs();
    _getModuloFromSharedPrefs();
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
          "Elige tu ávatar Femenino",
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
                      height: 125,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/banner_user.png"),
                        ),
                      ),
                    ),
                    //image avatar
                    Positioned(
                      top: 45,
                      left: MediaQuery.of(context).size.width * 0.40,
                      child: Container(
                          padding: const EdgeInsets.all(1.0),
                          width: 70,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: cellWidth,
                              height: cellHeight,
                              child: FadeInImage(
                                placeholder: const NetworkImage(
                                    'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw'),
                                image: NetworkImage(_imageUrl),
                                fit: BoxFit.cover,
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      left: 65,
                      top: 50,
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
/*                           Text(
                            _modulo,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'BubblegumSans',
                              fontSize: 13,
                            ),
                          ), */
                        ],
                      ),
                    ),
                    Positioned(
                      right: 50,
                      top: 45,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 1, 1),
                        child: Column(
                          children: [
                            const Text(
                              "Puntaje total",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'BubblegumSans',
                                  fontSize: 13),
                            ),
                            FutureBuilder<int>(
                              future: _modulo == 'Matemáticas'
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
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 500,
                    child: GridView.count(
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
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhto5YXa603LpbIiNTumqrADd40Fc6S232YLhJhaEhCfC3AeB9H6GT4sNma9P1rCQOS9HNCnzR5K2dt6lBzaVmyXEcgvaiR-qu7SStyF6WQU9agTA1rqYqR2k5qbyVZZSEgeawTocX_LOUHavGHEzUgjpiw1ZCAywy6a6Bjp9dOMbhao_tMcVyDtzI/w200-h200/av40.PNG',
                        ),
                        _buildAvatarButton(
                          index: 1,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGNAeVLIm7qjXH4uliNNcJuXKbgTbDPG7bk8Ywj9WaSeyAv3jMhX3Tjt9H3EDGVd0pHjjCz6QnUStIn6KuBAQ47hd_mQT5S4TwPA85FazCQeAoND55BBXldtLF8lPSjPDZoW-Y5osWbrVP7j_6CWKWchcE839uGC-X-7JpuPJ6E-cAp6S2Nd5BhF8/w200-h189/av39.PNG',
                        ),
                        _buildAvatarButton(
                          index: 2,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2HPERWI-5PdbOCRNCS_BBQ51yTuA30n_wsxkJ4JCPt2emqN3bTzgKjvqXuJE19O6kx-FDdy_Ha5-BT5-yQ6B2ZR9UGJhVwycm5u5Q8ysQL9jlsuVO4K3fjspseyQDcQSt88htxeb_2M0Zd_OM1xugV8gTPfy3lsBBFwYUGX4BgZxDerCf70AiUUo/w200-h196/av38.PNG',
                        ),
                        _buildAvatarButton(
                          index: 3,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeqit-yNgnoaU4lN3ufpbHxLKUYPIFSMPAvnmUHktoy_DAa60_aUPCyKQzLvAdofX3Pij0_veQzUoU5h50J7z6z5nh2pra6iqm0Bod-a4iY-9icPzkwcL203Bn4EaYnlQjYsQ5DFR8vSExo0tokNAuCIH22pyFU_i6kBqSC8HfySE9GSbp7i4P3Ac/w200-h196/av37.PNG',
                        ),
                        _buildAvatarButton(
                          index: 4,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjFdaYPkg9aZm_ocm0fXp3oP8f0b38Mu-P-iIz3JX2sEJx0N63ggbdkqrVxB-KtlWv-d3ZA7McoogC9com0R-xdMw_cmT7wJU053xL4mpmYTYcDSooRvD-71jT2cKC4BMRH1BOyQs6kJNUTUIdp6WI2NDegwjCkh_jI0AMlQh33mdvPwwzpepUx5LA/w200-h197/av36.PNG',
                        ),
                        _buildAvatarButton(
                          index: 5,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhY63wHjKuM1sMm_tGmk3QRKoXQsvakGUt4ve9wgw_7-JfW1RwXVRhdkE8VfPMrqwMh3euGJj6vVcFsrejuOpaedd60yNzGwv94aglPpECoSsb1mPUcpJQwYNVnfQ6MqZdNp5Gu8kHhtU_u7kOIL8JUeqh54scNowj_8RF-aA-HobbvMZSoKZe9_dE/w200-h190/av35.PNG',
                        ),
                        _buildAvatarButton(
                          index: 6,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYVJd_snGlKMOIs0BGZHIePJWKlxgEcw2ksFxkz4rv2EdBxvTs1trZHVdmukUsbOlwk96LPZFf8M7jmR9aMmX4RHuVu3dP0m7nfQKmUItOZG6ndTiTA6990P9XAVT-TeT1mX8Nhn4Ulbw3dyqLeGD__m7jHnNrkLjiOmOSt03zAMNn1lkSpInPLXc/w200-h197/av34.PNG',
                        ),
                        _buildAvatarButton(
                          index: 7,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPyIes_khLxavmec13ZS1wBgR7pxLeq5yWMmPCMrIfG_7-IFsPpbYIxggGngNiHcUI7eNaYVSDgyX82xtZVVzbGuuNBz-y-hTyG1JUjy3q_F-JSBjnLd8_wJ-gWptMWG4s0xGz0T3gmtzTdaPlc6Y43pxnrmxViZSA_X06R66ecPQhjnPfN5sZhaY/w198-h200/av33.PNG',
                        ),
                        _buildAvatarButton(
                          index: 8,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgv7wR9hLxGhj7kwmO1xdvvww_EgIjo2GNmH9Cyr6Ir72g_G36pJ97BclqTOQlY9OsmM4aTSaH-KT6R5EIdMM6PiW2vZy_IoHtHAauxzPWQmTT2V8TwRpqEbPqMRhOwPgdKJ17IieC3hsiv_VbFvkRo07va8igCQVLjD4I3yErtOe0ck4CJT0MHBm4/w200-h193/av32.PNG',
                        ),
                        _buildAvatarButton(
                          index: 9,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6acBiTVTbobSAXNqt2OzrSV6jjgqv6d_I0g9jKK7DYEY78QBJm5YW7-qxlFBy0nJXSsyfcrJ6Zk6Cd75CpGvjf79cmSq7J5G4LQHAxeZP-1mc8fHSkHcjk9ieFQ-u4RRtXZVIfZy7M6xRWSNdCc550Uxg8e7nXY-qB7DFou7Vk6WF3ryzsPdBa4E/w200-h185/av31.PNG',
                        ),
                        _buildAvatarButton(
                          index: 10,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiJ1LW0_VdGc2AgPc_YDhofyH7JJ5kI56aEwV8_smnf4qmXXSMXH1HxcGT6cEhB0GT1L1-HAl03mLII9upXS5jdEUbY3AUntfd6CbBwL_n3LPv7m3K1ZOs3uqyzPFCZu8rcsDIZ8a75xy3Qo8gfOmt5NAV_XCpk6R6449cvjE0-ZY9DlxMiXST6hwM/w200-h194/av30.PNG',
                        ),
                        _buildAvatarButton(
                          index: 11,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEidiWbwxSPUEg665riNMVaCHgpz29HrfxI8HpVCSinZELzHnls-aVP1iRpbQE_tUw9j_1Pxd2pXUcYJSALnz8YmIgj9nKDuxb9OZcan4rY-MDxHUNQr4NKy1ekoVq8DBeW0iKjVfR1qWEU6gwsqMMfx9zbPhwMS8BdfxijfM2IvFjjZu20Y9ZvvbBY/w198-h200/av29.PNG',
                        ),
                        _buildAvatarButton(
                          index: 12,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiXYXzHXIBLCjaVaRpeERS7i6tAem9LBn-sUctHu0bfMz_Rq280813p6LlYScNRpO6IGu3Cz25kHcz1r7j5srGEUfGalXh7ia0si_REOp2uXK4zmw1ituCkZi6DEpKIkxg95rE2fqYLldg1zRUB85kRVYxZpo4peLNp3lKtuhfwwXnjHB8Qyi938FI/w200-h188/av28.PNG',
                        ),
                        _buildAvatarButton(
                          index: 13,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh2RL31-WQ1S3E3XdYNa32XdVC6YweD6_tFBnFFU0SsK4K_UQtuv-aXJeHr9K1f1ZHUtCUbZkhNZY1iRklMvbcKTTO4RE9ymyOBZMCm9HV4ei-P7zPiyOOk4oP_SSSEUXAvpYaoS4BRTWgSupo6moBkfKJr2RD-nKkuGdt7fJOPIFJ2ZQPyn7rBmws/w194-h200/av27.PNG',
                        ),
                        _buildAvatarButton(
                          index: 14,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgwyC3swChFIMlJxz-Ry2tN6anNo3Lqa4_wlVK5QyF1AuCwI_h0xw4Rh-bL-6NPdGaBcA7-b_c7W5tMiXy-mhcm_by199iLXa7XnTWB4Gumc-cc1k9VRrQTCGQOmvyXOXcTwwDgg4Hn9pPxsEr0rXjMOoGcu2SbddEMbP1zvfktAbE4Rj-kMKL5u28/w198-h200/av26.PNG',
                        ),
                        _buildAvatarButton(
                          index: 15,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhuDtcaHx8lwqWjPYYlgKg6hXVeQAhAEr_iy2RLQ_1JKPnp9dQjhYZBU0Kkys9dFjM84LEGk3erElYs1yFTsMVxAMN3jfxZhLH5cAM0W5iD5VPuiNsCftUmkHLek6Z1F_pP8hD71PYbbP_MoSq0fGRsbNshyAoQwvNEVJdU2eFDxGIggV1JfCv_NYs/w200-h189/av24.PNG',
                        ),
                        _buildAvatarButton(
                          index: 16,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgS_-SAP46vT58CV0C4o302yZ82ral4pKFxm_gyq9i3KlPnIztcL9mTteGM8Ymmq4pgi_kSt0M5At7h7SS2NbnB-pXp76ng_r994ptKRgaFEgg0BRPwy2vDUNGk7QKFmQq4YI5TVg0TL1qrvSYa_KEIAD1WK5t5MlC8QSuMJSRDJngpbQYJThZShno/w200-h186/av25.PNG',
                        ),
                        _buildAvatarButton(
                          index: 17,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQqeLsFK6MUCxcjxA6YmyjgIE_AYMME-kNG2IAj0g62IKEZE21GE831Z9ywmq5W6LIV49O6KfjxicL0ZNZkJwvzXhvSUbyr4TdMCBy_oORFFe--zeQ0jXR3OlUXCfyFPxx0c3ZopHM0dP9igxKL6XOTsHLe-RdcOLrBuPv2mZxUq-F8_drsmIVKOg/w200-h193/av23.PNG',
                        ),
                        _buildAvatarButton(
                          index: 18,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhax6X3MpeVFB-IElovK0dHdc3JQS3zcOPfzIPOThj5Lm5BbPLHcZHH3T3rqdYjTac6lJXRHtRvxPXE0go4pXBHeesLwaDuST6q1vNf6UDY4QlFmzFDNWmOCR8AUV6OVIpd2px00WhUgb06PTkwfaLpa-eagT4fWbRSTt_C9oRnaL254jH6FUZKTwo/w183-h200/av22.PNG',
                        ),
                        _buildAvatarButton(
                          index: 19,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhIGcaRUqRXtRw5U2ACzMzeF_ahv7HUA866LhevJPVt39IP_CXMa_SMs1cmRsoZrRLUZKrEa62TF9SSNlz4-6mzwWNncepGzu1XMdSMhh3ftGP5YN78qsJTgz8c8s_u2A05bx5JX6BteioGTGoigHTnYpS6uZXUPALZ74JWi0SwT3oJlIuSTtjgg8I/w200-h199/av21.PNG',
                        ),
                        _buildAvatarButton(
                          index: 20,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgKzJi2T9hv3H0GnUJTrsvs_fYXodZv361cT5ctScAt7gJupOdEaUuVovQewaAKdYmURPqQyBtpvv4iTexCVXXE8jc0yiharOuxv4tMqndapyyMEaoa8XLzR-WfaLWln6OquM_-68XrCctHWdA-d-oN6t_wOeE6EKjMNdJfC17M2wDoO9M9ZWa1-Zg/w200-h191/av20.PNG',
                        ),
                        _buildAvatarButton(
                          index: 21,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi5EUWrV9yVGcE7nq9DUuLe6vwGucks-wSQhv7rBv0dZ0HzWerDUgu3nY-Ui2wNm5hU9h6hwy2dZhWIAD-rJSSvy4T0aa_3CYviN_e6Fp0qtbamxgaM9qVRsGYZ5DDazEyt5aHhylX_P4If9jgs6ldLMyy3DDSnQetGn0og8EFJyEs_gITfzYFvawo/w200-h170/av19.PNG',
                        ),
                        _buildAvatarButton(
                          index: 22,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCyHI3QIeCRERHTjwwKNgZvsCfw6mtLST8mvwsKFpKt77CE23sDpw5O0G_hGHS4lacVmX61aDXl_PMegLCyhZLL-hIaA6wRfqwLaAKB1XWHMF15P6SPIadWgeJodaJazQjNKnOCVshUy7JXtPa9NU4AoV5ToiYnQ-wCL1ZC647vOoRu52VQQ2JxO0/w200-h194/av18.PNG',
                        ),
                        _buildAvatarButton(
                          index: 23,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEirgwlxMaPM1ut-C4YJAKoZ5FzzgVmb32PHzQKCi4KGAbB-DgHli0ZQcsGEVQotUD-nU5Dv2MUcpemF4B8DmYkczEbz8jdAnrFOBF7GMCikfR_yFKxo6SQJ9sSiyNGBR8RYlUmA0RBLw3PO97lqfFN51rb42xjw_Ifqf03Ej60DAzs7-uSbyqIO5Fc/w200-h188/av17.PNG',
                        ),
                        _buildAvatarButton(
                          index: 24,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjfrXAZDuofTyqAmpjfhd-la815QP-47vRfXgmxKsv2gT2xZ2DpcCZGM6a62GntdJGnTJ5BrAethjYhZLiIbs0VMzd7ttNuht2xsDk65WjM576WooNzIGjlX7ZHfLppSIlUsMUihNXrNOfTge9SoWNplAkUEp5d-AH83hbSh7Uiw18bERZO4O4VwcQ/w200-h190/av16.PNG',
                        ),
                        _buildAvatarButton(
                          index: 25,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjVYMRkvfBMDiTRkvINyU87bLqBNrNPv1qy5pB09Wwglcb7tugw9R4PyG3QtV8ZW6ZIZRjcm53N11KsPLwF0alSAJwIlsatZ2ltSY4uEBQmhnCr5DZ8AcKo0BEhs8bWF-ZdzmHB-tppVfWY2ZtnYlJUw3iG32yBeB90SqURNB01rk45UmBmu7FUkRE/w200-h195/av15.PNG',
                        ),
                        _buildAvatarButton(
                          index: 26,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgDpwr1UhODHwXo_VCHvwU_KsuqurcJoW3xHletq3inQY7WoSRsp5Xjr7NIuuDd3bSSkiEEDOJpLpTRe6KvGUiA2avBWwUIwmB9HY0YXvsWyXMHIy3E_-sq4cX_ATCoImda8Ia8_mn2zHdP7zhSVCD0fYL_jyUp38oiliVBUtWiSZZDnx7NZ-d5wX8/w200-h193/av14.PNG',
                        ),
                        _buildAvatarButton(
                          index: 27,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZoYP10cm8FumP0Oiq3lvhGHoSWAExUfem8wDJ5SicMh-bN4ttwQqG6RhFVz_2Wrl1HXrPIVnl6QQ1YppcQZnH0aFz7hSsvVdWgcl3an8IXKEqVgpCflYF2vHaKwQkO6KofZjdMyJsKRrkzlHbfmAXjhySzMl7IsDc45dsGeBIfidqtv_PCMdMcVk/w200-h178/av13.PNG',
                        ),
                        _buildAvatarButton(
                          index: 28,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEggExKiusr2qORjsus_gBY9OQrcZcbkmdS4-fifsFaX5EWKqDflqxYSqlWOOHOkxrR5tV8nJgr1l57upae-5dhUaBm_9zS8bxkUoTReuDLKxLd1rqeUyQ3qbucU-UgDyyH0h0V2NfNUr7YCdeU0knHpDK59vZFj1eG-GBN4SbNPJnodubu2oszN-p0/w200-h174/av12.PNG',
                        ),
                        _buildAvatarButton(
                          index: 29,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjpMsw2nYbGeXQG7yF3GQtmgROo0ppH00k4bKBUs5Xa7CHpVGC6zV_pcJ0gw2lrkLtFmU3oyZD2F_659nByNoBTIRz5nMifn7a-jGN6F_cN6ZJK9UPszxfamwpG9RUDUmLbDM0xWTDKhCNjcyd_cjNrX0co5SxQt8e7aQmYgLBIvHkRBO6lopRrHUU/w189-h200/av11.PNG',
                        ),
                        _buildAvatarButton(
                          index: 30,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglr4PB2HMJrv6N2dRYMTTOo6aiRgryDpp4uQJZJk2ymNhY0w7ja81pGU72a-WIgQdTOU9VI4bIZ36h5iyUDLhiWRbOswoHwOKt6m44rGJ5ARg9NyE6uKE6nAt-W4n_IAS0awcjdumXIi-ZFb45RQXokVYlBzCmI6-d47BVl4z--5TiexHLa0B7y2A/w200-h193/av10.PNG',
                        ),
                        _buildAvatarButton(
                          index: 31,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhYFNlBK-LUnH-00Kl4DkVcFq8ctoXpB6VSD2OphSyi1fFF1b-qnDQ0NiKl2S_M0wunUlmFJvRCtbGwIQGh4IMMaK89ETWGrTHt4m36PNmVvv6KyaD1FxjCNdiS7xlhmmgkHXJ43JkHnGcETUn7rXNwjm3tbb9uXvhf4hn4ndbgUVADxD-vweB8cNU/w200-h185/av9.PNG',
                        ),
                        _buildAvatarButton(
                          index: 32,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjWOEeJ_mVZ0Fqx9v3--RYm43oxg5ablFP7seDi0eqV0fet6jOCGS2Aal2qZ0rSH8Kf4wguGlKGg2lGjuXqKCk7sGxn1HeI4TMXgrIrwknD3vKQCqclNbLOoLOB8AlJYT5WHsCFNmnp5ZtejOn_YzpfPiL6nXOnqzlnCMaPJ6DCpMkM2uJaOCXzQFw/w194-h200/av8.PNG',
                        ),
                        _buildAvatarButton(
                          index: 33,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhd0bcuyb_nETqk5yKa6QlsxykUzqxlKrwTSQtYLpaODnxtUGHgUb9w7i7pq2lqXCFdEV9GE_2dRrfuyM1v4sJzz5fdJy6UOjsv-SOFbqY0vvTEhv9HqBChBS2gtJzSKn5qPL2QumkENyHwrsZSbAYzgx_Q8ayvNjFHMsHrtH6cJdtQF5G07ZvCfZY/w200-h183/av7.PNG',
                        ),
                        _buildAvatarButton(
                          index: 34,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_VV6UC0ItudKhTRpRU6lhS-Ej-xHnvpWAhRTNAB-p_wZMNkPsE2DEHmw8h0-wsqYcMhWkLe-bH28vC58z7VU-7uO6qXvg1xL0GLsZBhLCzaGB7birxGb2hj9IMB342s2wkP9V3PHWIsuWnOCz-m3jzv-UzSmW5RUQFpdfSFTnwRbKzF6NHtG9_Ls/w200-h186/av6.PNG',
                        ),
                        _buildAvatarButton(
                          index: 35,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_BRjorn1dnxDMaJYFWEhQ_xv78yijJ8ytJT-gk8frm0wdvmXGgMFw4caSIxLzufxcLrm2eFM9uiOxsKFqi7wEDSCxMeMKUfk4UouEJp7otvIaE_wz87ge2KmLNaJ0mGqKfhnS19vOwhrwGNxHyTONl3PXjPUN48Ni1xpXpJ4M7mEKFhzliItn9J4/w200-h194/av5.PNG',
                        ),
                        _buildAvatarButton(
                          index: 36,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhLSL2UFat73krySxwlNjbctGH8Q1BCARfYB3xXNK_kwZu5zeu9oaESaLgCZXywq893k6SY-nA7AU-Sp__7n4q6LQl4hOU9whcNg9NAnVpW8T1F8UxxCIQbllsOlLcLoG7OsvCv2oXzkQb0QCiJY3Umd7micWsbHfMrPSzLpL9BFaSQtkuAHLETIlI/w197-h200/av4.PNG',
                        ),
                        _buildAvatarButton(
                          index: 37,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiHClvG6OHHV2M_YbsL45VuLIiMnZ4adV5eELdLCe1QwxKY3xUvCq1LjkSAUGhKq4JOLc7jxl-DW2ENPxgtGdxYX8XQThJILFea7oHmodRjgI_k_RyW-N1DEP_hRcoaPRPTKsNYIV3fSQ3i22f4HAt0fneIECIMnjME_7pXvZkseUHmyDiudKVMKAI/w200-h198/av3.PNG',
                        ),
                        _buildAvatarButton(
                          index: 38,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEggGP_jx_KvhvwjEE7GwLRrvAis22S5KVE2XoW-C7BIjDvkmujpsYMZv3SwiHXURMUq3GpZ5DKju72-clKrNbapbiVHOYLGSh3rWOCKCa2n72J02RVG7e_iGjW5msOVV1iKshTEqFOe8MsDWPyIN0tVRzIVGYY6_m6l8Bw9jxe_5jqFTLGw8Pbee7A/w200-h198/av2.PNG',
                        ),
                        _buildAvatarButton(
                          index: 39,
                          borderColorPressed: borderColorPressed,
                          borderColorNormal: borderColorNormal,
                          cellWidth: cellWidth,
                          cellHeight: cellHeight,
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhiAnS8zOgqplUbuFwQy9UITVXDdf8yjCKwjT92Ly4wqSJKASPekzqcbbriBZCMIYy256pROqaW_ZEFwdV3m8moFr3MyK0N0zYMiSA0HXi6Dqw5jmm70yMB19jvm9gI3NnZQsT0EwGh2m-aQrFBealjig5uYjHhvaYJtH9lt2k57MaAzjLQIbv-Sf4/w200-h192/av1.PNG',
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
      drawer: _getDrawer(context),
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

        bool primerAcceso;

        primerAcceso = prefs.getBool('primerAcceso')!;

        print('Avatar $index pressed');
        setState(() {
          _getAvatarFromSharedPrefs();

          if (primerAcceso == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const avatarsFemale()));

            primerAcceso = false;
            prefs.setBool('primerAcceso', primerAcceso);
          }
        });
      },
      highlightShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.green.withOpacity(0.5),
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
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;

    //firebase
    final user = FirebaseAuth.instance.currentUser!;

    String tecnicaElegida;

    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        color: colors_colpaner.base,
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
                    fadeInDuration: Duration.zero,
                    imageUrl: _imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(loggedInUser.fullName.toString(),
                        style: const TextStyle(
                            color: colors_colpaner.claro,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text('Técnica de ${loggedInUser.tecnica}',
                      style: const TextStyle(
                        color: colors_colpaner.claro,
                      )),
                  Text(loggedInUser.email.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: colors_colpaner.claro,
                      )),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            ListTile(
                title: const Text("Entrenamiento",
                    style: TextStyle(
                        color: colors_colpaner.oscuro,
                        fontWeight: FontWeight.bold)),
                leading: const Icon(
                  Icons.psychology,
                  color: colors_colpaner.oscuro,
                ),
                onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const entrenamientoModulos()))
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(
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
            ListTile(
              title: const Text("Ávatar",
                  style: TextStyle(
                    color: colors_colpaner.claro,
                  )),
              leading: const Icon(
                Icons.face,
                color: colors_colpaner.claro,
              ),
              //at press, run the method
              onTap: () {
                //si es primera vez que se ingresa, mstrar al usuario dialogo de genero a leegor
/*                 Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const genderDialog()));
              */
                Navigator.pop(context);
                //DialogHelper.gender_dialog(context);
              },
            ),
            ListTile(
              title: const Text("Patrones ICFES",
                  style: TextStyle(
                    color: colors_colpaner.oscuro,
                  )),
              leading: const Icon(
                Icons.insights,
                color: colors_colpaner.oscuro,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Usabilidad",
                  style: TextStyle(
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
              height: drawer_height * 0.15,
            ),
            Expanded(
              child: ListTile(
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
            ),
            const Divider(
              color: colors_colpaner.claro,
            ),
            ListTile(
              title: const Text("Cerrar sesión",
                  style: TextStyle(
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
    );
  }

  // función para eliminar todos los registros de Shared Preferences
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
