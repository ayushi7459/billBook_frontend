class User {
  final int? id;
  final String firstName;
  final String email;
  final String gender;
  final String phone;
  final String birthDate;

  User({
    this.id,
    required this.firstName,
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'email': email,
      'gender': gender,
      'phone': phone,
      'birthDate': birthDate,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      firstName: json['firstName'] as String,
      birthDate: json['birthDate'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
    );
  }
}
