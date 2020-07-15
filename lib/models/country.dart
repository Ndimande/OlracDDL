import 'package:database_repo/database_repo.dart';

class Country extends Model {
  String name;
  DateTime createdAt;

  Country({int id, this.name, this.createdAt}) : super(id: id);

  factory Country.fromMap(Map map) {
    return Country(
      id: map['id'] as int,
      name: map['name'],
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
