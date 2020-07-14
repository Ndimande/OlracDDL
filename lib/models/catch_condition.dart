import 'package:database_repo/database_repo.dart';

class CatchCondition extends Model {
  String name;
  DateTime createdAt;

  CatchCondition({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
    };
  }
}
