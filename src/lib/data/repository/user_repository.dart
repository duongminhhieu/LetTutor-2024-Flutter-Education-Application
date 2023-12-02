
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:src/data/model/user/user_data.dart';

class UserRepository {

  Future<UserData> getUserData() async {
    String data = await rootBundle.loadString('lib/assets/user-mock-data.json');
    dynamic jsonData = json.decode(data);

    UserData userData = UserData.fromJson(jsonData);

    return userData;
  }
}
