import '../entities/user.dart';
import '../repositories/user_repository.dart';

class AddUserUseCase {
  final UserRepository _userRepository;

  const AddUserUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<void> execute({required User user}) async {
    await _userRepository.createUser(user: user);
  }
}
