import 'package:database_repo/database_repo.dart';

class SeaBottomType extends Model {
  String name;
  DateTime createdAt;

  SeaBottomType({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdAt': createdAt,
    };
  }
}
