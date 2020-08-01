import 'package:database_repo/database_repo.dart';

class CatchCondition extends Model {
  String name;
  String namePortuguese;
  DateTime createdAt;

  CatchCondition({int id, this.name, this.namePortuguese, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'name_portuguese' : namePortuguese,
      //'created_at': createdAt == null ? null : createdAt.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'namePortuguese' : namePortuguese,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
