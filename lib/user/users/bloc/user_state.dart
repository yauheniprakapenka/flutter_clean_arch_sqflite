import 'package:domain/domain.dart';

abstract class UserState {
  const UserState();
}

class UserIsLoading implements UserState {
  const UserIsLoading();
}

class UserData implements UserState {
  final List<User> users;

  const UserData({
    required this.users,
  });
}
