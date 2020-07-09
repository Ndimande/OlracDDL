import 'package:database_repo/database_repo.dart';

class Port extends Model {
  String name;
  DateTime createdAt;

  Port({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'name': name,
    };
  }
}
