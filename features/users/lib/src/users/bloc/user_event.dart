import 'package:domain/domain.dart';

abstract class UserEvent {
  const UserEvent();
}

class CreateUser implements UserEvent {
  final User user;

  const CreateUser({required this.user});
}

class GetUsers implements UserEvent {
  const GetUsers();
}

class DeleteUserById implements UserEvent {
  final int id;

  const DeleteUserById({required this.id});
}

class UpdateUser implements UserEvent {
  final User user;

  const UpdateUser({
    required this.user,
  });
}
