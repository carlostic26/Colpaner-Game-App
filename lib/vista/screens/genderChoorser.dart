import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gamicolpaner/vista/dialogs/dialog_helper.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_male.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'avatars/avatars_female.dart';

class genderChooser extends StatefulWidget {
  const genderChooser({super.key});

  @override
  State<genderChooser> createState() => _genderChooserState();
}

class _genderChooserState extends State<genderChooser> {
  void setAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAvatar', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gif_fondo.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8), // Ajusta la opacidad aquí
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¡Bienvenido!",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'BubblegumSans',
                  fontWeight: FontWeight.bold,
                  color: colors_colpaner.claro,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                //elevation: 1,
                backgroundColor: colors_colpaner.claro,
                child: _buildChild(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildChild(BuildContext context) => SizedBox(
        height: 280,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Container(
            decoration: BoxDecoration(
              color: colors_colpaner.oscuro,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SizedBox(
              height: 50,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Selecciona tu género",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'BubblegumSans',
                      fontWeight: FontWeight.bold,
                      color: colors_colpaner.claro,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('gender', 'female');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const avatarsFemale()));
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/a/AVvXsEiwNbHhBZKC78E_eYo-ctXzHupB2Y3PsrE2MUKsIqJ7F0TjWQ5xM5ebfj6FWSQ-vVOQg0aUquYeIJbJf9wsIox2daQRZo80L3sqVt6Rk8V_Jlm8zxrr07y8pT9Bz9Z5US-lat0XyIT7e_7xYI7oQeRza1_sL7WjafszldUgsA0PskwS8QPSx1nDw1U',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('gender', 'male');

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const avatarsMale()));
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          "Femenino",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'BubblegumSans',
                            fontWeight: FontWeight.bold,
                            color: colors_colpaner.claro,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Masculino",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'BubblegumSans',
                          fontWeight: FontWeight.bold,
                          color: colors_colpaner.claro,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
