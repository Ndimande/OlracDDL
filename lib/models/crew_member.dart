import 'package:database_repo/database_repo.dart';

class CrewMember extends Model {
  String name;
  DateTime createdAt;

  CrewMember({int id, this.name, this.createdAt}) : super(id: id);

  factory CrewMember.fromMap(Map map) {
    return CrewMember(
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
