import 'dart:convert';

class GenericResponseModel {
  int responseCode;
  String responseMessage;
  GenericResponseModel({
    this.responseCode,
    this.responseMessage,
  });

  GenericResponseModel copyWith({
    int responseCode,
    String responseMessage,
  }) {
    return GenericResponseModel(
      responseCode: responseCode ?? this.responseCode,
      responseMessage: responseMessage ?? this.responseMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'responseCode': responseCode,
      'responseMessage': responseMessage,
    };
  }

  static GenericResponseModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GenericResponseModel(
      responseCode: map['responseCode'],
      responseMessage: map['responseMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  static GenericResponseModel fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'GenericResponseModel(responseCode: $responseCode, responseMessage: $responseMessage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GenericResponseModel &&
        o.responseCode == responseCode &&
        o.responseMessage == responseMessage;
  }

  @override
  int get hashCode => responseCode.hashCode ^ responseMessage.hashCode;
}
