
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

  getToken() async {
   
    var token = await userBox.get("token");
    return token;
  }
  getId() async {
   
    var id = await userBox.get("id");
    return id;
  }


  checkIsEmpty() {
    return userBox.isEmpty;
  }
}
