import 'package:domain/domain.dart';

class UserMapper {
  static const String _userFirstNameValue = 'firstName';
  static const String _userId = 'id';

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json[_userId] as int,
      firstName: json[_userFirstNameValue] as String,
    );
  }
}
