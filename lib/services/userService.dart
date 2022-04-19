import 'package:sqlite_flutter/db_Helper/repository.dart';

import '../Model/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }

  //save user
  SaveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //read all user
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //edit user
  updateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  //delete user
  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
