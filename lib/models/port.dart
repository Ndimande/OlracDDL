import 'package:database_repo/database_repo.dart';

class Port extends Model {
  String name;
  String namePortuguese;
  DateTime createdAt;

  Port({int id, this.name,this.namePortuguese, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'name_portuguese' : namePortuguese,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'namePortuguese' : namePortuguese,
      'createdAt': createdAt,
    };
  }
}
