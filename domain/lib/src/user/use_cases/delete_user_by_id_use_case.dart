import '../../../domain.dart';

class DeleteUseByIdUseCase {
  final UserRepository _userRepository;

  const DeleteUseByIdUseCase({required UserRepository userRepository}) 
      : _userRepository = userRepository;

  Future<void> execute({required int userId}) async {
    await _userRepository.deleteUserByID(userId: userId);
  }
}
