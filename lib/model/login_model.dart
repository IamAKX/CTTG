import 'dart:convert';

class LoginModel {
  String email;
  String password;
  LoginModel({
    this.email,
    this.password,
  });

  LoginModel copyWith({
    String email,
    String password,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  static LoginModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginModel(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static LoginModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'LoginModel(email: $email, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginModel && o.email == email && o.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
