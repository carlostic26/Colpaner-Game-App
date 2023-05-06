import 'package:shared_preferences/shared_preferences.dart';

class AvatarStorage {
  //static final String _avatarKey = 'avatar';

  static Future<bool> saveAvatar(String avatar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('Avatar', avatar);
  }

  static Future<String?> getAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('Avatar');
  }
}
