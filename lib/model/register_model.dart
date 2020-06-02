import 'dart:convert';

class RegisterModel {
  String name;
  String password;
  String email;
  RegisterModel({
    this.name,
    this.password,
    this.email,
  });

  RegisterModel copyWith({
    String name,
    String password,
    String email,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'email': email,
    };
  }

  static RegisterModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegisterModel(
      name: map['name'],
      password: map['password'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  static RegisterModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'RegisterModel(name: $name, password: $password, email: $email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RegisterModel &&
        o.name == name &&
        o.password == password &&
        o.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ password.hashCode ^ email.hashCode;
}
