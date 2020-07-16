import 'package:database_repo/database_repo.dart';

class Skipper extends Model {
  String name;
  DateTime createdAt;

  Skipper({int id, this.name, this.createdAt}) : super(id: id);

  factory Skipper.fromMap(Map map) {
    return Skipper(
      id: map['id'] as int,
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt'] as String),
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
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
