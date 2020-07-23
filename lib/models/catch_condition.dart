import 'package:database_repo/database_repo.dart';

class CatchCondition extends Model {
  String name;
  DateTime createdAt;

  CatchCondition({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'createdAt': createdAt == null ? null : createdAt.toIso8601String(),
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
