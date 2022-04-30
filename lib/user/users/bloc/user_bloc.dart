import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUserUseCase _addUserUseCase;
  final GetUsersUseCase _getUsersUseCase;

  UserBloc({
    required AddUserUseCase addUserUseCase,
    required GetUsersUseCase getUsersUseCase,
  })  : _addUserUseCase = addUserUseCase,
        _getUsersUseCase = getUsersUseCase,
        super(const UserIsLoading()) {
    on<AddUser>(_addUser);
    on<GetUsers>(_getUsers);
  }

  Future<void> _addUser(AddUser addUser, Emitter<UserState> emit) async {
    await _addUserUseCase.execute(user: addUser.user);
    await _getUsers(const GetUsers(), emit);
  }

  Future<void> _getUsers(GetUsers _, Emitter<UserState> emit) async {
    emit(const UserIsLoading());
    final List<User> users = await _getUsersUseCase.execute();
    emit(UserData(users: users));
  }
}
