import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users.dart';

class UserApp extends StatelessWidget {
  const UserApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            createUserUseCase: serviceLocator.get<CreateUserUseCase>(),
            getUsersUseCase: serviceLocator.get<GetUsersUseCase>(),
            deleteUseByIdUseCase: serviceLocator.get<DeleteUseByIdUseCase>(),
            updateUserUseCase: serviceLocator.get<UpdateUserUseCase>(),
          ),
        ),
      ],
      child: const _MaterialUserApp(),
    );
  }
}

class _MaterialUserApp extends StatelessWidget {
  const _MaterialUserApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: UsersPage(),
      ),
    );
  }
}
