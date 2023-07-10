import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamicolpaner/model/user_model.dart';

class ScoreFirebase {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void guardarTotalGamicolpaner(puntajeGlobal) async {
    final puntajesRefTotal = FirebaseFirestore.instance
        .collection('puntajes')
        .doc('podio')
        .collection('global')
        .doc(user!.uid);

    await puntajesRefTotal.set({
      'userId': loggedInUser.uid,
      'fullName': loggedInUser.fullName.toString(),
      'puntajeGlobal': puntajeGlobal,
      'tecnica': loggedInUser.tecnica.toString(),
      'avatar': loggedInUser.avatar.toString()
    });
  }
}
