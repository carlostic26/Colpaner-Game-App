class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? tecnica;
  String? sumScoreRC;
  String? sumScoreDS;

  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.tecnica,
      this.sumScoreRC,
      this.sumScoreDS});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      tecnica: map['tecnica'],
      sumScoreRC: map['sumScoreRC'],
      sumScoreDS: map['sumScoreDS'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'tecnica': tecnica,
      'sumScoreRC': sumScoreRC,
      'sumScoreDS': sumScoreDS,
    };
  }
}
