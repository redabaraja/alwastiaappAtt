import 'package:hive/hive.dart';

class LocalData {
  late Box userBox;
  openBox() async {
    await Hive.openBox("User");
    userBox = Hive.box("User");
  }

  addToken(String token) async {
    await userBox.put("token", token);
  }

  addId(String id) async {
    await userBox.put("id", id);
  }

  addUsername(String username) async {
    await userBox.put("username", username);
  }

  addPassword(String password) async {
    await userBox.put("password", password);
  }

  addType(String type) async {
    await userBox.put("type", type);
  }

  getToken() async {
    var token = await userBox.get("token");
    return token;
  }

  getId() async {
    var id = await userBox.get("id");
    return id;
  }

  getUsername() async {
    var id = await userBox.get("username");
    return id;
  }

  getPassword() async {
    var id = await userBox.get("password");
    return id;
  }

  getType() async {
    var type = await userBox.get("type");
    return type;
  }

  checkIsEmpty() {
    return userBox.isEmpty;
  }
}
