import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gamicolpaner/controller/services/avatar_storage.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_female.dart';
import 'package:gamicolpaner/vista/screens/avatars/avatars_male.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';

class generoChooser extends StatefulWidget {
  const generoChooser({super.key});

  @override
  State<generoChooser> createState() => _generoChooserState();
}

class _generoChooserState extends State<generoChooser> {
  @override
  Widget build(BuildContext context) {
    double drawer_width = MediaQuery.of(context).size.width * 0.70;
    double drawer_height = MediaQuery.of(context).size.height * 0.35;

    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, drawer_width, 20, 8),
        child: Container(
          decoration: BoxDecoration(
            color: colors_colpaner.oscuro,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            height: drawer_height,
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
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const avatarsFemale()));
                      },
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                                'https://blogger.googleusercontent.com/img/a/AVvXsEiwNbHhBZKC78E_eYo-ctXzHupB2Y3PsrE2MUKsIqJ7F0TjWQ5xM5ebfj6FWSQ-vVOQg0aUquYeIJbJf9wsIox2daQRZo80L3sqVt6Rk8V_Jlm8zxrr07y8pT9Bz9Z5US-lat0XyIT7e_7xYI7oQeRza1_sL7WjafszldUgsA0PskwS8QPSx1nDw1U')
                            .image,
                        radius: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const avatarsMale()));
                      },
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                                'https://blogger.googleusercontent.com/img/a/AVvXsEh98ERadCkCx4UOpV9FQMIUA4BjbzzbYRp9y03UWUwd04EzrgsF-wfVMVZkvCxl9dgemvYWUQUfA89Ly0N9QtXqk2mFQhBCxzN01fa0PjuiV_w4a26RI-YNj94gI0C4j2cR91DwA81MyW5ki3vFYzhGF86mER2jq6m0q7g76R_37aSJDo75yfa-BKw')
                            .image,
                        radius: 50,
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
                    Text(
                      "Femenino",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: colors_colpaner.claro,
                      ),
                    ),
                    SizedBox(
                      width: 70,
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
}
