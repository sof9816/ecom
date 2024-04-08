import 'package:ecom/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kTokenField = "t";
const kLangField = "lang";

class SessionManager {
  Future<void> deleteToken() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(kTokenField);
  }

  Future<void> persistAuthentication(String authJson) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(kTokenField, authJson);
  }

  Future<UserModel?> getAuthentication() async {
    final storage = await SharedPreferences.getInstance();
    final String json = storage.getString(kTokenField) ?? "";
    if (json != "") {
      return UserModel.fromJson(json);
    }
    return null;
  }

  Future<bool> hasToken() async {
    final UserModel? auth = await getAuthentication();
    if (auth == null) {
      return false;
    }
    return auth.token != "";
  }
}
