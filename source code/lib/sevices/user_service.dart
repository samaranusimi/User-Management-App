import 'dart:async';

import 'package:user_management/database_connection/repository.dart';
import 'package:user_management/models/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  saveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  readAllUserData() async {
    return await _repository.readData("users");
  }

  updateUser(User user) async {
    return await _repository.updatData('users', user.userMap());
  }

  deleteUser(userID) async {
    return await _repository.deleteDataByID('users', userID);
  }
}
