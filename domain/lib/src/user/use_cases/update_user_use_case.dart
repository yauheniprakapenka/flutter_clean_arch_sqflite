import '../../../domain.dart';

class UpdateUserUseCase {
  final UserRepository _userRepository;

  const UpdateUserUseCase({required UserRepository userRepository}) 
      : _userRepository = userRepository;

  Future<void> execute({required User user}) async {
    await _userRepository.updateUser(user: user);
  }
}
