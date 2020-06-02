import 'dart:convert';

class UserModel {
  String name;
  String email;
  String id;
  String password;
  int status;
  UserModel({
    this.name,
    this.email,
    this.id,
    this.password,
    this.status,
  });

  UserModel copyWith({
    String name,
    String email,
    String id,
    String password,
    int status,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'password': password,
      'status': status,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      name: map['name'],
      email: map['email'],
      id: map['id'],
      password: map['password'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, id: $id, password: $password, status: $status)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.name == name &&
        o.email == email &&
        o.id == id &&
        o.password == password &&
        o.status == status;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        id.hashCode ^
        password.hashCode ^
        status.hashCode;
  }
}
