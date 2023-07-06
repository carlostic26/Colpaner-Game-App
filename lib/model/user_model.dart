class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? tecnica;
  String? avatar;

  UserModel({this.uid, this.email, this.fullName, this.tecnica, this.avatar});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      tecnica: map['tecnica'],
      avatar: map['avatar'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'tecnica': tecnica,
      'avatar': avatar,
    };
  }
}
