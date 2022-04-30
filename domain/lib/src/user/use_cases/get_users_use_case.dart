import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  const GetUsersUseCase({required UserRepository userRepository}) 
      : _userRepository = userRepository;

  Future<List<User>> execute() async {
    return _userRepository.getUsers();
  }
}
