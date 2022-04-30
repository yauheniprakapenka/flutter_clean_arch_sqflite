import 'package:domain/domain.dart';

abstract class UserLocalDataSource {
  Future<void> createUser({required User user});

  Future<List<User>> getUsers();

  Future<void> deleteUserByID({required int userId});
}
