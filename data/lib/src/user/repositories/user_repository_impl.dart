import 'dart:developer';

import 'package:domain/domain.dart';

import '../data_sources/local/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _userLocalDataSource;

  const UserRepositoryImpl({required UserLocalDataSource userLocalDataSource})
      : _userLocalDataSource = userLocalDataSource;

  @override
  Future<void> createUser({required User user}) async {
    try {
      await _userLocalDataSource.createUser(user: user);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      return await _userLocalDataSource.getUsers();
    } on Exception catch (e) {
      log(e.toString());
      return <User>[];
    }
  }

  @override
  Future<void> deleteUserByID({required int userId}) async {
    try {
      await _userLocalDataSource.deleteUserByID(userId: userId);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
