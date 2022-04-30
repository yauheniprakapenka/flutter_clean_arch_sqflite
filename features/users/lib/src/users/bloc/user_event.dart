import 'package:domain/domain.dart';

abstract class UserEvent {
  const UserEvent();
}

class AddUser implements UserEvent {
  final User user;

  const AddUser({required this.user});
}

class GetUsers implements UserEvent {
  const GetUsers();
}

class DeleteUserById implements UserEvent {
  final int id;

  const DeleteUserById({required this.id});
}
