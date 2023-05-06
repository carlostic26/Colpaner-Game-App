import 'package:gamicolpaner/vista/screens/entrenamiento_modulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pin = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Bienvenido",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
/*           alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(children: [
                      const Text(
                        "Código de acceso\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Ingresa el pin",
                        ),
                        onChanged: (String value) {
                          setState(() {
                            pin = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          if (pin == '0000000') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => entrenamientoModulos()),
                            );
                          } else {
                            //toast: Pin inválido.
                          }
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "* Se requiere un pin de 7 dígitos para ingresar a la app. Si eres estudiante pregúntale al maestro encargado.",
                  ),
                ),
              ],
            ),
          ), */
            ),
      ),
      drawer: _getDrawer(context),
    );
  }

  //NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    double drawer_height = MediaQuery.of(context).size.height;
    double drawer_width = MediaQuery.of(context).size.width;
    return Drawer(
      width: drawer_width * 0.60,
      elevation: 0,
      child: Container(
        color: Color.fromARGB(255, 185, 238, 198),
        child: ListView(
          children: <Widget>[
            Container(
              //height: 150.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 185, 238, 198),
                  image: DecorationImage(
                      image: AssetImage('assets/blue_background.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 5.0),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/psd-gratis/3d-ilustracion-persona-gafas-sol_23-2149436200.jpg?w=360'),
                  ),
                  SizedBox(height: 10.0),
                  Text("Oscar Canelo",
                      style: TextStyle(
                          color: Color.fromARGB(255, 42, 42, 42),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  Text("Técnica de Sistemas",
                      style: TextStyle(color: Color.fromARGB(255, 91, 91, 91))),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
            ListTile(
                title: const Text("Entrenamiento",
                    style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
                leading: const Icon(
                  Icons.psychology,
                  color: Colors.grey,
                ),
                onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const entrenamientoModulos()),
                      )
                    }),
            ListTile(
                title: const Text("Mis Puntajes",
                    style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
                leading: const Icon(
                  Icons.sports_score,
                  color: Colors.grey,
                ),
                onTap: () {}),
            ListTile(
              title: const Text("Ávatar",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.face,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Patrones ICFES",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.insights,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {},
            ),
            ListTile(
              title: const Text("Usabilidad",
                  style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
              leading: const Icon(
                Icons.extension,
                color: Colors.grey,
              ),
              //at press, run the method
              onTap: () {},
            ),
            SizedBox(
              height: drawer_height * 0.25,
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListTile(
                title: const Text("",
                    style: TextStyle(color: Color.fromARGB(255, 99, 99, 99))),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                //at press, run the method
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
