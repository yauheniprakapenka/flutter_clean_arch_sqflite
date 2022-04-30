import 'package:domain/domain.dart';

import '../../data.dart';
import '../user/data_sources/local/user_local_data_source.dart';
import '../user/data_sources/local/user_sqflite_data_source.dart';
import '../user/repositories/user_repository_impl.dart';

final GetIt serviceLocator = GetIt.I;

class DataDI {
  void initDependencies() {
    serviceLocator
      ..registerSingleton<UserLocalDataSource>(
        UserSqfliteDataSource(),
      )
      ..registerSingleton<UserRepository>(
        UserRepositoryImpl(userLocalDataSource: serviceLocator.get<UserLocalDataSource>()),
      )
      ..registerSingleton<CreateUserUseCase>(
        CreateUserUseCase(userRepository: serviceLocator.get<UserRepository>()),
      )
      ..registerSingleton<GetUsersUseCase>(
        GetUsersUseCase(userRepository: serviceLocator.get<UserRepository>()),
      )
      ..registerSingleton<DeleteUseByIdUseCase>(
        DeleteUseByIdUseCase(userRepository: serviceLocator.get<UserRepository>()),
      )
      ..registerSingleton<UpdateUserUseCase>(
        UpdateUserUseCase(userRepository: serviceLocator.get<UserRepository>()),
      );
  }
}
