import 'package:database_repo/database_repo.dart';

class MoonPhase extends Model {
  String name;
  DateTime createdAt;

  MoonPhase({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
    };
  }
}
