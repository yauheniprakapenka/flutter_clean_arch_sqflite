import '../entities/user.dart';

abstract class UserRepository {
  Future<void> createUser({required User user});

  Future<List<User>> getUsers();
}
