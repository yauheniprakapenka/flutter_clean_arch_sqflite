import 'package:domain/domain.dart';

class UserMapper {
  static const String _userFirstNameValue = 'firstName';

  static User fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json[_userFirstNameValue] as String,
    );
  }
}
