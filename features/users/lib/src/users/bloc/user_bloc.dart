import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUseCase _createUserUseCase;
  final GetUsersUseCase _getUsersUseCase;
  final DeleteUseByIdUseCase _deleteUseByIdUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  UserBloc({
    required CreateUserUseCase createUserUseCase,
    required GetUsersUseCase getUsersUseCase,
    required DeleteUseByIdUseCase deleteUseByIdUseCase,
    required UpdateUserUseCase updateUserUseCase,
  })  : _createUserUseCase = createUserUseCase,
        _getUsersUseCase = getUsersUseCase,
        _deleteUseByIdUseCase = deleteUseByIdUseCase,
        _updateUserUseCase = updateUserUseCase,
        super(const UserIsLoading()) {
    on<CreateUser>(_addUser);
    on<GetUsers>(_getUsers);
    on<DeleteUserById>(_deleteUserById);
    on<UpdateUser>(_updateUser);
  }

  Future<void> _getUsers(GetUsers _, Emitter<UserState> emit) async {
    emit(const UserIsLoading());
    final List<User> users = await _getUsersUseCase.execute();
    emit(UsersData(users: users));
  }

  Future<void> _addUser(CreateUser addUser, Emitter<UserState> emit) async {
    await _createUserUseCase.execute(user: addUser.user);
    await _getUsers(const GetUsers(), emit);
  }

  Future<void> _deleteUserById(DeleteUserById deleteUserById, Emitter<UserState> emit) async {
    await _deleteUseByIdUseCase.execute(userId: deleteUserById.id);
    await _getUsers(const GetUsers(), emit);
  }

  Future<void> _updateUser(UpdateUser updateUser, Emitter<UserState> emit) async {
    await _updateUserUseCase.execute(user: updateUser.user);
    await _getUsers(const GetUsers(), emit);
  }
}
