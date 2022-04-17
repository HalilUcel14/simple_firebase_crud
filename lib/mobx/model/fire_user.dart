import 'package:hucel_core/hucel_core.dart';

class FireUser extends BaseModel {
  /// base model abstract olarak otomatik eklentiler için kullanıyorum. hucel_core paketimden geliyor.
  String id;
  final String name;
  final int age;

  FireUser({
    required this.id,
    required this.age,
    required this.name,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return FireUser(
      id: json['id'],
      age: json['age'],
      name: json['name'],
    );
  }

  static FireUser fromJsons(Map<String, dynamic> json) {
    return FireUser(
      id: json['id'],
      age: json['age'],
      name: json['name'],
    );
  }

  @override
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
