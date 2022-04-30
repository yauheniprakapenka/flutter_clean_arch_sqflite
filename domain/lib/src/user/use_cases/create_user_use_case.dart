import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;

  const CreateUserUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<void> execute({required User user}) async {
    await _userRepository.createUser(user: user);
  }
}
