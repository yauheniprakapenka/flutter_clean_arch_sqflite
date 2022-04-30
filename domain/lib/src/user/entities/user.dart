class User {
  final int? id;
  final String firstName;

  const User({
    this.id,
    required this.firstName,
  });

  User copyWith({
    int? id,
    String? firstName,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
    );
  }
}
