import 'package:domain/domain.dart';

abstract class UserState {
  const UserState();
}

class UserIsLoading implements UserState {
  const UserIsLoading();
}

class UsersData implements UserState {
  final List<User> users;

  const UsersData({
    required this.users,
  });
}
