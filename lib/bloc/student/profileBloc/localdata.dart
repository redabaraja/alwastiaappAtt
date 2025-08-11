import 'package:hive/hive.dart';
import 'package:alwastia/bloc/student/profileBloc/model.dart';

class LocalUserInfo {
  late Box userinfoBox;
  openBox() async {
    await Hive.openBox("UserInfo");
    userinfoBox = Hive.box("UserInfo");
  }

  addData(var data) async {
    await userinfoBox.put("data", data);
  }

  getData() async {
    var data = await userinfoBox.get("data");
    print(data);
    return UserModel.fromMap(data);
  }

  checkIsEmpty() {
    return userinfoBox.isEmpty;
  }
}
